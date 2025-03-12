;; driver-verification
;; Manages driver credentials, verification status, and background checks

;; Define data structures
(define-map drivers
  { driver-id: principal }
  {
    name: (string-ascii 50),
    license-number: (string-ascii 20),
    vehicle-info: (string-ascii 100),
    verification-status: (string-ascii 10), ;; "pending", "verified", "rejected"
    background-check-hash: (string-ascii 64), ;; Hash of background check results
    insurance-info: (string-ascii 100),
    registration-date: uint,
    last-updated: uint
  }
)

;; Define a map for verification authorities
(define-map verification-authorities
  { authority-id: principal }
  { active: bool }
)

;; Define error codes
(define-constant err-unauthorized (err u401))
(define-constant err-already-registered (err u409))
(define-constant err-not-found (err u404))

;; Initialize contract owner
(define-data-var contract-owner principal tx-sender)

;; Add a verification authority
(define-public (add-verification-authority (authority principal))
  (begin
    (asserts! (is-eq tx-sender (var-get contract-owner)) err-unauthorized)
    (ok (map-set verification-authorities { authority-id: authority } { active: true }))
  )
)

;; Register as a driver
(define-public (register-driver
  (name (string-ascii 50))
  (license-number (string-ascii 20))
  (vehicle-info (string-ascii 100))
  (insurance-info (string-ascii 100)))

  (let ((driver-exists (is-some (map-get? drivers { driver-id: tx-sender }))))
    (begin
      (asserts! (not driver-exists) err-already-registered)
      (ok (map-insert drivers
        { driver-id: tx-sender }
        {
          name: name,
          license-number: license-number,
          vehicle-info: vehicle-info,
          verification-status: "pending",
          background-check-hash: "",
          insurance-info: insurance-info,
          registration-date: block-height,
          last-updated: block-height
        }))
    )
  )
)

;; Update driver verification status
(define-public (update-verification-status (driver principal) (status (string-ascii 10)) (background-check-hash (string-ascii 64)))
  (let ((authority-active (default-to false (get active (map-get? verification-authorities { authority-id: tx-sender })))))
    (begin
      (asserts! authority-active err-unauthorized)
      (asserts! (is-some (map-get? drivers { driver-id: driver })) err-not-found)
      (ok (map-set drivers
        { driver-id: driver }
        (merge (unwrap-panic (map-get? drivers { driver-id: driver }))
          {
            verification-status: status,
            background-check-hash: background-check-hash,
            last-updated: block-height
          }
        )))
    )
  )
)

;; Get driver details
(define-read-only (get-driver-details (driver principal))
  (map-get? drivers { driver-id: driver })
)

;; Check if driver is verified
(define-read-only (is-driver-verified (driver principal))
  (let ((driver-data (map-get? drivers { driver-id: driver })))
    (if (is-some driver-data)
      (is-eq (get verification-status (unwrap-panic driver-data)) "verified")
      false
    )
  )
)


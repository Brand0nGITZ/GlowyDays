
            function openModall(orderId) {
                document.getElementById("trackingModal").style.display = "block";
                document.getElementById("modalOrderId").value = orderId;
                document.getElementById("displayOrderId").textContent = orderId;
            }

            document.querySelector(".close").onclick = function () {
                document.getElementById("trackingModal").style.display = "none";
            }

            window.onclick = function (event) {

                const modal = document.getElementById("trackingModal");
                if (event.target == modal) {
                    modal.style.display = "none";
                }
            }

            let sortDirection = {}; // Keep track of each column's sort direction

            function sortTable(columnIndex) {
                const table = document.querySelector(".order-table");
                const tbody = table.querySelector("tbody");
                const rows = Array.from(tbody.querySelectorAll("tr"));

                // Default to ascending if it's never been sorted
                const isAsc = sortDirection[columnIndex] = sortDirection[columnIndex] === undefined ? true : !sortDirection[columnIndex];

                rows.sort((a, b) => {
                    const cellA = a.children[columnIndex].textContent.trim();
                    const cellB = b.children[columnIndex].textContent.trim();

                    const valA = isNaN(cellA) ? (Date.parse(cellA) ? new Date(cellA) : cellA.toLowerCase()) : Number(cellA);
                    const valB = isNaN(cellB) ? (Date.parse(cellB) ? new Date(cellB) : cellB.toLowerCase()) : Number(cellB);

                    if (valA < valB)
                        return isAsc ? -1 : 1;
                    if (valA > valB)
                        return isAsc ? 1 : -1;
                    return 0;
                });

                tbody.innerHTML = "";
                rows.forEach(row => tbody.appendChild(row));
            }

            function confirmDelete(orderId) {
                return confirm("Are you sure you want to delete Order ID: " + orderId + "?");
            }

            function filterTable() {
                const input = document.getElementById("searchOrderId");
                const filter = input.value.trim().toLowerCase();
                const table = document.querySelector(".order-table");
                const rows = table.querySelectorAll("tbody tr");

                rows.forEach(row => {
                    const orderIdCell = row.children[1]; // Order ID is the second column (index 1)
                    const orderIdText = orderIdCell.textContent.trim().toLowerCase();
                    row.style.display = orderIdText.includes(filter) ? "" : "none";
                });
            }

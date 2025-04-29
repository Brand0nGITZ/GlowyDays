document.addEventListener('DOMContentLoaded', function() {
    // Toggle sidebar
    const toggleBtn = document.getElementById('toggle-sidebar');
    const sidebar = document.querySelector('.sidebar');
    
    toggleBtn.addEventListener('click', function() {
        sidebar.classList.toggle('expanded');
    });
    
    // Responsive behavior
    function checkWidth() {
        if (window.innerWidth <= 768) {
            sidebar.classList.remove('expanded');
        } else {
            sidebar.classList.remove('expanded');
        }
    }
    
    // Check on load
    checkWidth();
    
    // Check on resize
    window.addEventListener('resize', checkWidth);
    
    // Menu item active state
    const menuItems = document.querySelectorAll('.sidebar-menu li');
    
    menuItems.forEach(item => {
        item.addEventListener('click', function() {
            // Remove active class from all items
            menuItems.forEach(i => i.classList.remove('active'));
            
            // Add active class to clicked item
            this.classList.add('active');
        });
    });
    
    // Simulate loading data (for demonstration purposes)
    function simulateDataUpdate() {
        const cards = document.querySelectorAll('.stat-card');
        
        cards.forEach(card => {
            const statValue = card.querySelector('h2');
            const currentValue = parseInt(statValue.textContent);
            
            // Add a small random change to simulate data updates
            const change = Math.floor(Math.random() * 5) - 2; // Random number between -2 and 2
            const newValue = Math.max(1, currentValue + change); // Ensure value doesn't go below 1
            
            // Animate the change
            animateValue(statValue, currentValue, newValue, 500);
        });
        
        // Schedule next update
        setTimeout(simulateDataUpdate, 30000); // Update every 30 seconds
    }
    
    // Helper function to animate number changes
    function animateValue(element, start, end, duration) {
        let startTimestamp = null;
        const step = (timestamp) => {
            if (!startTimestamp) startTimestamp = timestamp;
            const progress = Math.min((timestamp - startTimestamp) / duration, 1);
            const value = Math.floor(progress * (end - start) + start);
            element.textContent = value;
            if (progress < 1) {
                window.requestAnimationFrame(step);
            }
        };
        window.requestAnimationFrame(step);
    }
    
    // Start the simulation after a delay
    setTimeout(simulateDataUpdate, 5000);
});
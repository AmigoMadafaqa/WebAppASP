// refers to : https://www.javascripttutorial.net/web-apis/javascript-notification/


    document.addEventListener('DOMContentLoaded', async () => {
        if ('Notification' in window) {
            if (Notification.permission === 'granted') {
                showNotification(title, body, buttonId, url);
            } else {
                Notification.requestPermission().then((permission) => {
                    if (permission === 'granted') {
                        showNotification(title, body, buttonId, url);
                    } else {
                        console.log("Notification access denied or not given");
                    }
                });
            }
        }


        // Function to show a notification
        function showNotification(title, body, buttonId, url) {
            const showNotiBtn = document.getElementById(buttonId);

            // Ensure the button with the dynamically generated ID exists
            if (showNotiBtn) {
                const notification = new Notification(title, {
                    body: body,
                });

                // Open a new window when the notification is clicked
                notification.addEventListener('click', () => {
                    // Handle the click event with opening a url
                    window.open(url);
                });
            } else {
                console.error('Button not found with ID:', buttonId);
            }
        }
    }






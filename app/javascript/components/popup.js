// create alert when user not signed in try to access employee's information
export function showPopup() {
  const div = document.createElement("div");
  div.innerHTML = `
    <div role="alert" class="fixed inset-0 flex items-center justify-center bg-light-gray bg-opacity-75 z-50">
        <div class="w-80 px-4 py-4 text-base text-white bg-dark-purple rounded-lg font-regular shadow-lg">
            <div class="flex items-start">
                <div class="shrink-0">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2"
                        stroke="currentColor" class="w-6 h-6">
                        <path stroke-linecap="round" stroke-linejoin="round"
                            d="M11.25 11.25l.041-.02a.75.75 0 011.063.852l-.708 2.836a.75.75 0 001.063.853l.041-.021M21 12a9 9 0 11-18 0 9 9 0 0118 0zm-9-3.75h.008v.008H12V8.25z"></path>
                    </svg>
                </div>
                <div class="ml-3">You must be signed in to access employee's information</div>
                <button onclick="this.closest('div[role=alert]').remove();" class="ml-auto text-white">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="w-4 h-4">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
                    </svg>
                </button>
            </div>
        </div>
    </div>`;
  document.body.appendChild(div);
  setTimeout(() => {
    div.remove();
  }, 5000);
}

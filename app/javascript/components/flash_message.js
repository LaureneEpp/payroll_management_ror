// create flash message when admin when to update user role
const teamLeaders = document.getElementsByClassName("team-leader");

export function showFlashMessage(event) {
  const flashMessage = document.createElement("div");

  flashMessage.setAttribute("role", "alert");
  flashMessage.className =
    "flash-message fixed flex items-center justify-center bg-medium-emerald z-10 rounded-lg shadow-lg";
  flashMessage.style.left = `${event.pageX + 15}px`;
  flashMessage.style.top = `${event.pageY + 15}px`;

  flashMessage.innerHTML = `
          <div class="w-80 px-4 py-4 text-base text-white bg-dark-purple rounded-lg font-medium shadow-lg">
              <div class="flex items-start">
                  <div class="shrink-0">
                      <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2"
                          stroke="currentColor" class="w-6 h-6">
                          <path stroke-linecap="round" stroke-linejoin="round"
                              d="M11.25 11.25l.041-.02a.75.75 0 011.063.852l-.708 2.836a.75.75 0 001.063.853l.041-.021M21 12a9 9 0 11-18 0 9 9 0 0118 0zm-9-3.75h.008v.008H12V8.25z"></path>
                      </svg>
                  </div>
                  <div class="ml-3 flex flex-col items-center m-1">
                      <p>No new team leader without the manager role!</p>
                  </div>
              </div>
          </div>
      `;

  document.body.appendChild(flashMessage);

  setTimeout(() => {
    if (flashMessage) flashMessage.remove();
	}, 3000);
	
	// avoid replicate - make the flashmessage only shown once when mouseover
  if (teamLeaders.length > 0) {
    for (let i = 0; i < teamLeaders.length; i++) {
      teamLeaders[i].removeEventListener("mouseover", showFlashMessage);
    }
  }
}

if (teamLeaders.length > 0) {
  for (let i = 0; i < teamLeaders.length; i++) {
    teamLeaders[i].addEventListener("mouseover", showFlashMessage);
  }
}

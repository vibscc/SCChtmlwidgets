HTMLWidgets.widget({

  name: 'dropdown',

  type: 'output',

  factory: function(el, width, height) {

    // https://stackoverflow.com/a/2117523
    function uuidv4() {
      return ([1e7] + -1e3 + -4e3 + -8e3 + -1e11).replace(/[018]/g, c =>
        (c ^ crypto.getRandomValues(new Uint8Array(1))[0] & 15 >> c / 4).toString(16)
      );
    }

    const uuid = uuidv4();

    const selectPlot = function (parentContainerId, plotId) {
      const container = document.getElementById(parentContainerId);

      if (! container) {
        return;
      }

      [...container.children].forEach(child => {

        if (! child.classList.contains('hidden') && child.id !== plotId) {
          child.classList.add('hidden');
        }

        if (child.id === plotId) {
          child.classList.remove('hidden');
        }
      });
    }

    return {

      renderValue: function(x) {
        const select = document.createElement('select');
        const plotRoot = document.createElement('div');
        plotRoot.id = uuid;

        let option, plotContainer, child;
        Object.keys(x.data).forEach((name, index) => {
          option = document.createElement('option');
          option.value = uuid + '-' + name;
          option.text = name;

          select.appendChild(option);

          plotContainer = document.createElement('div');
          plotContainer.id = uuid + '-' + name;
          if (index !== 0) {
            plotContainer.classList.add('hidden');
          }

          plotContainer.innerHTML = x.data[name];
          child = plotContainer.firstChild;

          if (child instanceof SVGElement) {
            child.setAttribute("width", "100%");
            child.setAttribute("height", "auto");
          }

          plotRoot.appendChild(plotContainer);
        });

        select.addEventListener("change", (e) => selectPlot(uuid, e.target.value));

        el.appendChild(select);
        el.appendChild(plotRoot);
    },

      resize: function(width, height) {

      // TODO: code to re-render the widget with a new size

      }

    };
  }
});

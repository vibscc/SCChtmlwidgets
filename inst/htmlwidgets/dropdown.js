HTMLWidgets.widget({

  name: 'dropdown',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: make this a random UUID
    const uuid = 'abcdefghij';

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

          option.addEventListener("click", (e) => selectPlot(uuid, e.target.value));
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

        el.appendChild(select);
        el.appendChild(plotRoot);
    },

      resize: function(width, height) {

      // TODO: code to re-render the widget with a new size

      }

    };
  }
});

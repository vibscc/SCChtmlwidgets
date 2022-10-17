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
        const svgRoot = document.createElement('div');
        svgRoot.id = uuid;

        let option, svgContainer;
        Object.keys(x.data).forEach((name, index) => {
          option = document.createElement('option');
          option.value = uuid + '-' + name;
          option.text = name;

          option.addEventListener("click", (e) => selectPlot(uuid, e.target.value));
          select.appendChild(option);

          svgContainer = document.createElement('div');
          svgContainer.id = uuid + '-' + name;
          if (index !== 0) {
            svgContainer.classList.add('hidden');
          }

          svgContainer.innerHTML = x.data[name];
          svgRoot.appendChild(svgContainer);
        });

        el.appendChild(select);
        el.appendChild(svgRoot);
    },

      resize: function(width, height) {

      // TODO: code to re-render the widget with a new size

      }

    };
  }
});

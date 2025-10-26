const { renderApp } = require('../src/App');

test('renders without crashing', () => {
  expect(renderApp()).toBe('App rendered');
});

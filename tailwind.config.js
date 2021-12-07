module.exports = {
  purge: ["./app/**/*.html.erb"],
  darkMode: false, // or 'media' or 'class'
  theme: {
    colors: {
      purple: {
        light: '#8b80fe',
        DEFAULT: '#6c60ff',
        dark: '#271ca2',
      },
      pink: {
        DEFAULT: '#fec2f2',
      },
      white: {
        DEFAULT: '#fffdff',
      },
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
};

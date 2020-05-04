module.exports = (eleventyConfig) => {
  eleventyConfig.addPassthroughCopy('pages/styles/protocol.css');
  eleventyConfig.addPassthroughCopy('pages/images/');
  eleventyConfig.addPassthroughCopy('search_index/');
  eleventyConfig.addPassthroughCopy('.nojekyll');
  eleventyConfig.addPassthroughCopy('pages/service-worker.js');

  return {
    pathPrefix: '/protocol/',
    dir: {
      input: 'pages',
      output: 'protocol',
      data: '_data',
    },
  };
};

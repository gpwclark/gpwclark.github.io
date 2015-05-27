---
layout: post
title: Bootstrapping a Personal/Organizational GitHub Page with Jekyll 
date: 2015-05-26 19:01:10 
---

## Intro
Jekyll is a great ruby-based static site generation tool. It is especially
useful because GitHub pages uses Jekyll by default. GitHub actually allows
its users to host static sites for themselves, their organizations, or their
projects. We are going to focus on personal sites. Everyone can get a personal
site, the url is "githubuser.github.io". Jekyll users have an upperhand here 
because GitHub will automatically compile your site for you. This is an easy
and desirable solution, especially since Jekyll is a great tool.

### Setup
First install jekyll: [http://jekyllrb.com/docs/installation/](http://jekyllrb.com/docs/installation/).

Then:
```
$ jekyll new myblog
$ cd myblog
```

If you run the command:
```
tree ./ # you will see...

./
├── about.md
├── _config.yml
├── css
│   └── main.scss
├── feed.xml
├── _includes
│   ├── footer.html
│   ├── header.html
│   └── head.html
├── index.html
├── _layouts
│   ├── default.html
│   ├── page.html
│   └── post.html
├── LICENSE
├── _posts
│   └── 2015-05-26-welcome-to-jekyll.markdown
├── README.md
└── _sass
    ├── _base.scss
        ├── _layout.scss
            └── _syntax-highlighting.scss

```

### Getting to know jekyll
There are two folders you need to pay particular attention to:
*  _includes
* _layouts

Jekyll is just a text transformation engine. It looks for .html and .md files 
that are in the root directory/user created directory, it then applies a layout
, and can directly include text from any file in the _includes directory. The 
output, by default, goes into the _site directory (created when the site is
built). The _site directory has the same directory structure as the jekyll
directory itself, minus all of the files prepended with an underscore.
To understand the text transformation powers of jekyll run:

```
jekyll build #this compiles your site as it is to the _site directory
tree _site

_site
├── about
│   └── index.html
├── css
│   └── main.css
├── feed.xml
├── index.html
├── jekyll
│   └── update
│       └── 2015
│           └── 05
│               └── 26
│                   └── welcome-to-jekyll.html
├── LICENSE
└── README.md
```

As you can see every non-underlined file and folder appeared in the _site
directory. Understanding what happened to index.html and about.md will
fully explain how jekyll works. Jekyll starts with a layout. The default
layout is simple:

###################################THIS##########################


As you can see 2 important jekyll things are being done here. 

* The include syntax with '{' and '%' above looks for files in the _includes 
  directory. The three files it includes are head.html, header.html, and 
  footer.html. The text of these files is included inline.
  These three files are the core of what keeps your site's look 
  consistent, they are three of the files we will be adding bootstrap code to,
  and it is natural they will be included in any file with the "default" layout. 
* The double curly brace syntax around the text "content" is where jekyll
  sticks the body of the file it is transforming.

This means that the index.html in the root directory was transformed, into an
.html file that looks just like default.html, but with all of the text from
the three files in the include statements, as well as the body of the raw
or un-transformed index.html file where the content tag is located.

By default the index.html file looks like

THIS######################################################3333333


This raw or un-transformed .html file that lives in the root of the jekyll 
directory is what appears in the content tag of the default.html. The only
missing link is the syntax in the first three lines. Jekyll calls everything
between the triple ---- as frontmatter. A file with frontmatter indicates
that some transformations need to be applied before the file is done. The
frontmatter in index.html just says 'layout: default'. There are many 
possible values that frontmatter can take on 
([see the docs](http://jekyllrb.com/docs/frontmatter/)). 'layout' is an
important variable to set in frontmatter because it specifies what file
should serve as the template or layout from the _layouts folder. This of 
course means that the value of the layout frontmatter variable must
correspond to the name of a file in the _layouts directory.


### Pages and posts

Jekyll is built for blogging, so talking about posts is important and of course
very easy to understand, but pages are also important in sites, and jekyll
does those well too.

#### Pages
In the default jekyll directory, there is also an about.md file. In the
transformation (pictured above), this about.md file turned into:
```
├── about
│   └── index.html
```

There are three frontmatter variables here. The last two are easy to explain,
'title' is the page title, it can be referenced by a variable, 
([see the docs](http://jekyllrb.com/docs/variables/)), and 'permalink' is what
specifies the behavior of the transformed file. about.md was in the root directory
but it becomes /about/index.html because of the permalink variable.
The 'layout' frontmatter variable here is 'page' this is interesting because of 
the contents of page:

```
```

This file, page.html, is itself a layout. It is different from default.html 
because it has frontmatter. This means that Jekyll supports nested layouts.
You can define default.html to be the barebones html that all of your html
files need, then you can define pages or groups of pages, that have some 
additional html specific to their type, and as long as they include the 
frontmatter variable 'layout' set to default, they will appear consistently.

#### Posts
Jekyll is designed to handle posts so it is very much a 'solved' problem.
All posts go into the _posts folder. Post files are named
YEAR-MONTH-DAY-title.markdown. They must also include frontmatter, followed
by the markdown that serves as the body of the post:

```
```

Since it is explained so well I must defer to 
[Jekyll's documentation](http://jekyllrb.com/docs/posts/)
for all post related questions. I will know focus on
building a very basic site.

### Jekyll and Twitter Bootstrap
Twitter Bootstrap is a very easy to use library that allows for very
intuitive and pretty websites to be built with minimal effort. To use
the library we need to edit the head.html file in the _includes directory.
It goes in the head.html directory because we are going to stick with the
default.html layout as the base for our site. Given this, we need all of the
bootstrap files to be available on every page. The bootstrap site we are going
to build will have a home page, an about page, and a page that lists all of
the blog posts from your _posts folder. To navigate between those pages, we 
will use a navbar.

First we need to add the following to _includes/head.html:
```
```

This ensures that all of the css/js we need for bootstrap will be available to us.
The rest of the work I did for you.
```
git clone https://github.com/gpwclark/user.github.io
```

If you run jekyll serve in that directory you will see the basic site we were
building up to. The head.html, header.html, and footer.html have some default
bootstrap code in them. Most importantly, header.html has the code for the
navbar. The navbar has three links, home, about, and blog. These correspond to
index.html, about.md, and blog.md in the root directory. The index.html file
has some more baked in bootstrap code, and the blog.md file uses a feature
of Liquid, the templating engine Jekyll uses, to list all of the posts,
currently, just the intro post.

This repo is good enough to serve as a base for your personal page. Create a
repo named yourghusername.github.io and copy the contents of user.github.io
in there. When you commit the changes, GitHub will build it for you and host
it at yourghusername.github,io.

Make sure to reference the [Jekyll site](http://jekyllrb.com/) to fill in the
rest of the gaps in your knowledge about Jekyll. Twitter also has
[great documentation](http://getbootstrap.com/).

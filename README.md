# Live URL

https://redhat-composer-ai.github.io/documentation/

## Editing the Site

It is highly recommended you download [Obsidian](https://obsidian.md/) and use that to update the docs. Note you need to set your Obsidian vault(File system) to point to the `/content` folder.

## Creating a new Page

To create a new page in the Obsidan Browser

Add a new note:

![new note](.assets/newnote.png)

Apply Template `notes` to the newly created page:

![apply template](.assets/addtemplate.png)

## Run Site Locally

The following can be used to validate the site looks correct

`npm run docs`

`npx quartz build --serve -d content`

## Push new site

Updates to the main branch will kick off the gitlab pipeline building a new version of the docs.
 

Pipeline - Eliminate boiler-plate code for AJAX interactions
============================================================

## DESCRIPTION

Pipeline enables you to replace sub-elments of a named html-element with new html. Pipeline achieves this via AJAX.

Our approach consists of three steps:
  * Prerequisite: A view is rendered already in the user's browser.

  1. the user or an automated action trigger an asyncronous AJAX request to a controller action.
  2. the controller action renders a partial view and returns it as JSON.
  3. client-side AJAX code replaces all sub-elements of the named html element with the rendered view from #2.

Pipeline makes it easy to perform these steps.

## EXAMPLE USE

Two steps are necessary to update a page with Pipeline:

* Create an action that renders an partial update to a page. 
	
	* When processing the server request, the controller action will inject markup (or any JS code) that will automaticaly be executed at the client. The rails code to perform this is:
           
           ```
           class TestAsync < ApplicationController
             def asyncAction
               ...               
               //Initialize variables to render view here
               ...
               render_for_pipeline("some_view_to_be_rendered", "", "") { |rendered_view| 
                 <<-eos
                    $(this.relativeTo).parents(".replaceME").html(rendered_view); 
                    // injects/replaces html markup on the browser 
                 eos
               } 
             end
           end
           ```


* Insert a 'rel=async' attribute into your html to trigger an asyncronous page update (e.g on a link or form submit).

	*  Add a "rel=async" attribute to wire a click or form submission to happen asynchronously. For example,
		
		```
                <div class="replaceME"">
                  <a href="/asyncAction" rel="async">Click Me, I'm Async</a> 
                  <form action="/some_url" method="post" rel="async"></form>
                </div>
		```

When the triggers the asyncronous call, by for instance clicking a link with a 'rel="async"' attribute, Pipeline will automatically replace sub-elements of a named
html element (e.g. '.replaceME') with the view rendered by 'asyncAction'.

## INSTALLATION

The best way to install Pipeline is via Gemfile:

    gem "pipeline", :git => 'git://github.com/legalreach/pipeline.git'

Then require the pipeline javascsript by adding the following line to application.js:
   
    //= require 'pipeline'

## COMPANIES ALREADY USING THIS

LegalReach, MyDressAffair

## CONTRIBUTE

If you'd like to hack on Pipeline, start by forking my repo on GitHub:

http://github.com/legalreach/pipeline

If you have any ideas or suggestions, feel free to contact me at avlok@legalreach.com


Copyright © 2011 Avlok Kohli of LegalReach, released under the MIT license

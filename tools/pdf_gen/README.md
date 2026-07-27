# PDF Generator Tool

This tool is used to generate the CV pdf directly from the MKDocs page. It uses the [mkdocs-print-site-plugin](https://github.com/timvink/mkdocs-print-site-plugin/) to do so.

This tool generates a local page with just the index and minimal support to generate the PDF.

## Customize

### CSS Style
To generate a PDF with custom styling the generated page uses a different ```extra_style.css``` which is located in ```tools/pdf_gen```.

This file may be modified to adjust the page for the PDF generation without having to adjust the main MKDocs page.

### Index.md Content
The content of the ```index.md``` also can be adjusted.

All the lines between following lines will be skipped.
```
<!-- print skip start -->
...
<!-- print skip end -->
```

To add content only for the PDF file, add the following:
```
<!-- print only start
...
print only end -->
```

To replace contents, just combine the two:
```
<!-- print skip start -->
--- Content only for page ---
<!-- print skip end -->

<!-- print only start
--- Content only for PDF ---
print only end -->
```

## Run

To run the scrip from the root dir:
```
./tools/pdf_gen/prepare_print.sh
```
Once the MKDocs page is served, open the print page:
[http://127.0.0.1:8000/personal-page/print_page/](http://127.0.0.1:8000/personal-page/print_page/)

This will open the generated print page on the browser. To generate the PDF:
1. On the browser, select tools, print. This should open the print menu.
2. Select save to PDF.
3. On Margins adjust the margins, since it is not done by default.
    * On firefox selecting custom margins with 0.5in for each side give a nice result.
4. Make sure ```print header and footers``` is disabled.
5. On ```Pages``` select _custom_, the 2-3 to only print the second and third page.

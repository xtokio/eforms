# eforms

Simple forms creation and follow ups

https://eforms.mischicanadas.com <br>
User: lgomez <br>
Pass: lgomez <br>

## Installation

```crystal
crystal build src/eforms.cr --release
```

## Usage

Default values in `.env` file
`PUBLIC_PATH`   where the default folder will be with the application assets.
`PORT`          application port number.
`DATABASE_PATH` where the application SQLite database is stored.

ENV
```bash
PUBLIC_PATH=/Users/luis/Dropbox/Code/Crystal/apps/eforms/public
DATABASE_PATH=/Users/luis/Dropbox/Code/Crystal/apps/eforms/db/eforms.db
PORT=3000
```
eForm structure
```html
<form class="grid-form">          
  <fieldset>
    <legend>Section title 1</legend>

    <div data-row-span="2">
      <div data-field-span="1">
        <label>Element label</label>
        <!-- Custom element -->
      </div>
      <div data-field-span="1">
        <label>Element label</label>
        <!-- Custom element -->
      </div>
    </div>
  </fieldset>
</form>
```

eForm custom elements
```html
<!-- All elements must have an id attribute -->

<!-- Input element -->
<input id="txt_element" type="text">

<!-- Input datetime picker element -->
<input type="text" id="dtp_datepicker" class="datepicker-custom">

<!-- Checkbox element -->
<input type="checkbox" id="chk_element_1">
<label for="chk_element_1">Checkbox 1</label>

<!-- Radiobutton element -->
<input class="radio" id="rdb_element_1" name="rd" type="radio">
<label for="rdb_element_1" class="radio-label">Radio 1</label>

<!-- Single select dropdown -->
<select id="cmb_simple" class="simple">
  <option value="1">Option 1</option>
  <option value="2">Option 2</option>
</select>

<!-- Multiple select dropdown -->
 <select id="cmb_multiple" class="multiple" multiple>
    <option value="1">One</option>
    <option value="2">Two</option>
    <option value="3">Three</option>
    <option value="4">Four</option>
    <option value="5">Five</option>
  </select>

```

eForm basic template
```html
<form class="grid-form">          
  <fieldset>
    <legend>Section title 1</legend>

    <div data-row-span="4">
      <div data-field-span="1">
        <label>Student ID</label>
        <input id="txt_student_id" type="text">
      </div>
      <div data-field-span="2">
        <label>Student Full Name</label>
        <input id="txt_student_full_name" type="text">
      </div>
      <div data-field-span="1">
        <label>Date of Birth</label>
        <input type="text" id="dtp_datepicker" class="datepicker-custom">
      </div>
    </div>
  </fieldset>

  <fieldset>
    <legend>Section title 2</legend>

    <div data-row-span="2">
      <div data-field-span="1">
        <label>Languages</label>
        <input type="checkbox" id="box-2">
        <label for="box-2">English</label>

        <input type="checkbox" id="box-3">
        <label for="box-3">Spanish</label>

      </div>
      <div data-field-span="1">
        <label>Gender</label>
        <input class="radio" id="radio-1" name="rd" type="radio">
        <label for="radio-1" class="radio-label">Male</label>

          <input class="radio" id="radio-2" name="rd" type="radio">
        <label for="radio-2" class="radio-label">Female</label>
      </div>
    </div>

    <div data-row-span="2">
      <div data-field-span="1">
        <label>Simple select</label>
        <select id="cmb_simple" class="simple">
          <option value="AL">Alabama</option>
          <option value="WY">Wyoming</option>
        </select>
      </div>

      <div data-field-span="1">
        <label>Multiple select</label>
        <select id="cmb_multiple" class="multiple" multiple>
          <option value="1">One</option>
          <option value="2">Two</option>
          <option value="3">Three</option>
          <option value="4">Four</option>
          <option value="5">Five</option>
        </select>
      </div>
    </div>

  </fieldset>
</form>
```

## Screenshots

Login page

![eforms 01](screenshots/screenshot_01.png)

Dashboard

![eforms 02](screenshots/screenshot_02.png)

New eForm

![eforms 03](screenshots/screenshot_03.png)

Open eForms

![eforms 04](screenshots/screenshot_04.png)

eForm details

![eforms 05](screenshots/screenshot_05.png)

eForm update / creation

![eforms 06](screenshots/screenshot_06.png)

## Development

1. Add documentation on how to create an eForm
2. Refactor dashboard
3. Import `csv` file

## Contributing

1. Fork it (<https://github.com/xtokio/eforms/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Luis Gomez](https://github.com/xtokio) - creator and maintainer

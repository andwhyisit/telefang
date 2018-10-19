"use strict";

var FONT_METRIC_SHEET_NAME = "Font metrics";
var FONT_IMAGE_SHEET_NAME = "Font graphics";

var CHARMAP_URL = 'https://raw.githubusercontent.com/telefang/telefang/patch/charmap.asm';
var FONT_NAMES = ['normal', 'bold', 'narrow'];
var FONT_METRIC_CSV_URLS = {
  normal: 'https://raw.githubusercontent.com/telefang/telefang/patch/components/mainscript/font.tffont.csv',
  bold: 'https://raw.githubusercontent.com/telefang/telefang/patch/components/mainscript/font_bold.tffont.csv',
  narrow: 'https://raw.githubusercontent.com/telefang/telefang/patch/components/mainscript/font_narrow.tffont.csv'
};
var FONT_IMAGE_URLS = {
  normal: 'https://raw.githubusercontent.com/telefang/telefang/patch/gfx/font.png',
  bold: 'https://raw.githubusercontent.com/telefang/telefang/patch/gfx/bold_font.png',
  narrow: 'https://raw.githubusercontent.com/telefang/telefang/patch/gfx/narrow_font.png'
};

function updateFontSheets() {
  var charmap = fetchCharmap();
  var metrics = fetchFontMetrics();
  var images = fetchFontImages();
  populateFontMetricSheet(charmap, metrics);
  populateFontImageSheet(images);
}

function fetchCharmap() {
  var r = UrlFetchApp.fetch(CHARMAP_URL);
  var charmap = r.getContentText('utf-8');
  charmap = parseCharmap(charmap);
  return charmap;
}

function fetchFontMetrics() {
  var metrics = {};
  
  for (var i = 0; i < FONT_NAMES.length; i++) {
    var font_name = FONT_NAMES[i];
    r = UrlFetchApp.fetch(FONT_METRIC_CSV_URLS[font_name]);
    var widths = parseMetricCsv(r.getContentText('utf-8'));
    metrics[font_name] = widths;
  }
  
  return metrics;
}

function fetchFontImages() {
  var image_blobs = {};
  
  for (var i = 0; i < FONT_NAMES.length; i++) {
    var font_name = FONT_NAMES[i];
    r = UrlFetchApp.fetch(FONT_IMAGE_URLS[font_name]);
    var blob = r.getAs('image/png');
    image_blobs[font_name] = blob;
  }
  
  return image_blobs;
}

function populateFontMetricSheet(charmap, metrics) {
  var sheet = getFontMetricSheet();
  
  var values = []
  for (var i = 0; i < charmap.length; i++) {
    var char = charmap[i][0];
    // Escape Sheets's special characters.
    if (char[0] === '=' || char[0] === '\'') {char = '\'' + char;}
    var code = charmap[i][1];
    var row = [char];
    for (var j = 0; j < FONT_NAMES.length; j++) {
      row.push(metrics[FONT_NAMES[j]][code]);
    }
    values.push(row);
  }
  
  var numRows = sheet.getFrozenRows() + values.length;
  var numCols = sheet.getFrozenColumns() + values[0].length;
  setSheetDimensions(sheet, numRows, numCols);
  
  var range = sheet.getRange(sheet.getFrozenRows() + 1, sheet.getFrozenColumns() + 1, values.length, values[0].length);
  range.setValues(values);
  
  // And some formatting as the cherry on top.
  var textRange = sheet.getRange(range.getRow(), range.getColumn(), range.getNumRows(), 1);
  
  var numRange = sheet.getRange(range.getRow(), range.getColumn() + 1, range.getNumRows(), range.getNumColumns() - 1);
  textRange.setNumberFormat('@');
  numRange.setNumberFormat('#');
}

function populateFontImageSheet(images) {
  var sheet = getFontImageSheet();
  
  var values = [[]];
  for (var i = 0; i < FONT_NAMES.length; i++) {
    var encoded = Utilities.base64Encode(images[FONT_NAMES[i]].getBytes());
    values[0].push(encoded);
  }
  
  var numRows = sheet.getFrozenRows() + values.length;
  var numCols = sheet.getFrozenColumns() + values[0].length;
  setSheetDimensions(sheet, numRows, numCols);
  
  var range = sheet.getRange(sheet.getFrozenRows() + 1, sheet.getFrozenColumns() + 1, values.length, values[0].length);
  range.setValues(values);
  range.setNumberFormat('@');
}

function getChars(sheet, totalRows, frozenRows, frozenCols) {
  if (typeof sheet === 'undefined' ||
      typeof totalRows === 'undefined' ||
      typeof frozenRows === 'undefined' ||
      typeof frozenCols === 'undefined') {
    sheet = getFontMetricSheet();
    var dataRange = sheet.getDataRange();
    totalRows = dataRange.getLastRow();
    frozenRows = sheet.getFrozenRows();
    frozenCols = sheet.getFrozenColumns();
  }
  
  var chars = sheet.getRange(frozenRows + 1, frozenCols + 1, totalRows - frozenRows).getValues();
  chars = chars.map(function(x) {return x[0];});
  return chars;
}

function getFontMetrics() {
  var sheet = getFontMetricSheet();
  var dataRange = sheet.getDataRange();
  var totalRows = dataRange.getLastRow();
  var frozenRows = sheet.getFrozenRows();
  var frozenCols = sheet.getFrozenColumns();
  
  var chars = getChars(sheet, totalRows, frozenRows, frozenCols);
  
  var fonts = {};
  for (var i = 0; i < FONT_NAMES.length; i++) {
    var width_map = fonts[FONT_NAMES[i]] = {};
    var widths = sheet.getRange(frozenRows + 1, frozenCols + 1 + 1 + i, totalRows - frozenRows).getValues();
    for (var j = 0; j < chars.length; j++) {
      width_map[chars[j]] = widths[j][0];
    }
  }
  
  return fonts;
}

function getFontImages() {
  var sheet = getFontImageSheet();
  var frozenRows = sheet.getFrozenRows();
  var frozenCols = sheet.getFrozenColumns();
  
  var images = {};
  for (var i = 0; i < FONT_NAMES.length; i++) {
    var encoded = sheet.getRange(frozenRows + 1 + i, frozenCols + 1).getValue();
    images[FONT_NAMES[i]] = Utilities.newBlob(Utilities.base64Decode(encoded), 'image/png');
  }
  
  Logger.log(images);
  
  return images;
}

function getFontMetricSheet() {
  return tryGetSheet(FONT_METRIC_SHEET_NAME);
}

function getFontImageSheet() {
  return tryGetSheet(FONT_IMAGE_SHEET_NAME);
}

function tryGetSheet(name) {
  var sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName(name);
  if (!sheet) {throw "Sheet \"" + name + "\" not found.";}
  return sheet;
}

function setSheetDimensions(sheet, numRows, numCols) {
  var currentRows = sheet.getMaxRows();
  var currentCols = sheet.getMaxColumns();

  if (currentRows > numRows) {
    sheet.deleteRows(numRows + 1, currentRows - numRows);
  } else if (currentRows < numRows) {
    sheet.insertRowsAfter(currentRows, numRows - currentRows);
  }
  
  if (currentCols > numCols) {
    sheet.deleteColumns(numCols + 1, currentCols - numCols);
  } else if (currentCols < numCols) {
    sheet.insertColumnsAfter(currentCols, numCols - currentCols);
  }
}

// The """ charmap is actually incorrect RGBDS code, but exists
// in Telefang's charmap file since it goes through a Python
// script and never actually through RGBDS.
var CHARMAP_LINE_RE = /^(?:charmap "("|[^"]+)",\s*(|\$|%|&)([0-9A-Fa-f]+))?\s*(?:;.*)?$/;
function parseCharmap(s) {
  var charmap = [];
  var lines = s.split('\n');
  for (var i = 0; i < lines.length; i++) {
    var line = lines[i];
    var m = line.match(CHARMAP_LINE_RE);
    if (!m[1]) {continue;}
    
    var char = m[1];
    char = {'\\n': '\n'}[char] || char;
    var base = {'': 10, '$': 16, '%': 2, '&': 8}[m[2]];
    var number = parseInt(m[3], base);
    charmap.push([char, number]);
  }
  return charmap;
}

function parseMetricCsv(s) {
  var table = parseCsv(s);
  table = table.slice(1); // Remove header row.
  table = table.map(function(row) {return row.slice(1);}); // Remove header column.
  
  // Only handles hexadecimal numbers prefixed by a $.
  table = table.map(function(row) {
    return row.map(function(num) {return parseInt(num.slice(1), 16);});
  });
  
  return table.reduce(function(x, y) {return x.concat(y);});
}

function parseCsv(s) {
  // Only handles super simple CSVs without quoted fields and all that.
  var parsed = s.split('\n');
  if (!parsed[parsed.length - 1]) {parsed = parsed.slice(0, parsed.length - 1);}
  parsed = parsed.map(function(line) {return line.split(',');})
  return parsed;
}

<?php

use App\Models\Store;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});
Route::get('/print-qr/{store}', function (Store $store) {
    return view('print-qr', compact('store'));
})->name('print.qr');


use Illuminate\Support\Facades\Artisan;

Route::get('/clear-all-cache', function() {
    Artisan::call('optimize:clear');
    return 'All caches cleared successfully!';
});
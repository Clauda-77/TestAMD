<?php

use App\Models\Store;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Artisan;

 

Route::get('/', function () {
    return view('welcome');
});
Route::get('/print-qr/{store}', function (Store $store) {
    return view('print-qr', compact('store'));
})->name('print.qr');

 

Route::get('/clear-all-cache', function() {
    Artisan::call('optimize:clear');
    return 'All caches cleared successfully!';
});


 

Route::get('/run-clear', function () {
    Artisan::call('route:clear');
    Artisan::call('config:clear');
    Artisan::call('view:clear');
    Artisan::call('cache:clear');
    return '✅ All caches cleared successfully!';
});
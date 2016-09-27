<?php

  use Sabre\DAV;

  // The autoloader
  require 'vendor/autoload.php';

  // Now we're creating a whole bunch of objects
  $root = array(
      new DAV\SimpleCollection("one", [ new DAV\FS\Directory("/webdav/one") ] ),
      new DAV\SimpleCollection("two", [ new DAV\FS\Directory("/webdav/two") ] ),
      new DAV\SimpleCollection("three", [ new DAV\FS\Directory("/webdav/deeper/three" ) ] )
  );

  // The server object is responsible for making sense out of the WebDAV protocol
  $server = new DAV\Server($root);

  // If your server is not on your webroot, make sure the following line has the
  // correct information
  $server->setBaseUri('/');

  // The lock manager is reponsible for making sure users don't overwrite
  // each others changes.
  $lockBackend = new DAV\Locks\Backend\File('data/locks');
  $lockPlugin = new DAV\Locks\Plugin($lockBackend);
  $server->addPlugin($lockPlugin);

  // This ensures that we get a pretty index in the browser, but it is
  // optional.
  $server->addPlugin(new DAV\Browser\Plugin());

  // All we need to do now, is to fire up the server
  $server->exec();


$root = array(
    new DAV\SimpleCollection('users'),
    new DAV\SimpleCollection('files'),
    new DAV\SimpleCollection('home')
);

$server = new DAV\Server($root);
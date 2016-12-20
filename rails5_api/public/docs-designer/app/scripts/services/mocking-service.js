(function () {
  'use strict';

  angular.module('ramlEditorApp')
    .service('mockingService', function mockingServiceFactory(
      mockingServiceClient,
      mockingServiceUtils,
      ramlRepository
    ) {
      var self = this;

      function getMockMeta(file) {
        return ramlRepository.loadMeta(file)
          .then(function success(meta) {
            return meta.mock;
          })
        ;
      }

      function setMockMeta(file, mock) {
        return ramlRepository.loadMeta(file)
          .then(function success(meta) {
            meta.mock = mock;
            return ramlRepository.saveMeta(file, meta);
          })
          .then(function success() {
            return mock;
          })
        ;
      }

      self.getMock = function getMock(file) {
        return getMockMeta(file);
      };

      self.createMock = function createMock(file, raml) {
        return dereferenceRaml(raml)
          .then(function () {
            return mockingServiceClient.createMock({
              raml: file.contents,
              json: raml
            });
          })
          .then(function (mock) {
            return setMockMeta(file, mock);
          })
        ;
      };

      self.updateMock = function updateMock(file, raml) {
        return dereferenceRaml(raml)
          .then(function () {
            return getMockMeta(file);
          })
          .then(function (mock) {
            return mock && mockingServiceClient.updateMock(angular.extend(mock, {
              raml: file.contents,
              json: raml
            }));
          })
          .then(function (mock) {
            return setMockMeta(file, mock);
          })
        ;
      };

      self.deleteMock = function deleteMock(file) {
        return getMockMeta(file)
          .then(function (mock) {
            return mock && mockingServiceClient.deleteMock(mock);
          })
          .then(function success() {
            return setMockMeta(file, null);
          })
        ;
      };

      // ---

      function dereferenceRaml(raml) {
        return mockingServiceUtils.dereference(raml)
          .catch(function (error) {
            console.error('dereferenceRaml failed', error.stack);
          })
        ;
      }
    })
  ;
})();

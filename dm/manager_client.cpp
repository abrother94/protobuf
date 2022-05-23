/*
 *
 * Copyright 2015 gRPC authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

#include <iostream>
#include <memory>
#include <string>

#include <grpcpp/grpcpp.h>
#include "manager.grpc.pb.h"

using grpc::Channel;
using grpc::ClientContext;
using grpc::Status;
using manager::device_management;
using manager::Device;
using manager::HttpData;

class DMClient {
 public:
  DMClient(std::shared_ptr<Channel> channel)
      : stub_(device_management::NewStub(channel)) {}

  std::string GenericDeviceAccess() {
    Device t_device;
    HttpData reply;

    ClientContext context;

    Status status = stub_->GenericDeviceAccess(&context, t_device, &reply);

    if (status.ok()) {
      return "RPC ok";
    } else {
      std::cout << status.error_code() << ": " << status.error_message() << std::endl;
      return "RPC failed";
    }
  }

 private:
  std::unique_ptr<device_management::Stub> stub_;
};

int main(int argc, char** argv) {
  DMClient dm_client(grpc::CreateChannel(
      "localhost:50051", grpc::InsecureChannelCredentials()));

  dm_client.GenericDeviceAccess();

  return 0;
}

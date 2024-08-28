#include <iostream>
#include <aws/core/Aws.h>
#include <aws/s3/S3Client.h>
#include <aws/core/utils/logging/LogLevel.h>
#include <aws/core/client/ClientConfiguration.h>

using namespace Aws;

int main()
{
    std::cout << "Daemon\n";

    // initialize AWS SDK
    SDKOptions options;
    options.loggingOptions.logLevel = Utils::Logging::LogLevel::Debug;
    InitAPI(options);

    // create S3 client with local endpoint configuration
    Aws::Client::ClientConfiguration clientConfig;
    clientConfig.endpointOverride = "http://localhost:4566";
    const Aws::S3::S3Client s3Client(clientConfig);
    auto outcome = s3Client.ListBuckets();

    // check list of the S3 buckets
    if (!outcome.IsSuccess()) {
        std::cerr << "Failed with error: \n" << outcome.GetError()
                << '\n';
        Aws::ShutdownAPI(options);
        return 1;
    } else if (outcome.GetResult().GetBuckets().size() == 0) {
        std::cout << "No buckets found!\n" << outcome.GetError()
                  << '\n';
        Aws::ShutdownAPI(options);
        return 1;
    } else {
        std::cout << "Found " << outcome.GetResult().GetBuckets().size()
                  << " buckets\n";
        for (auto &bucket: outcome.GetResult().GetBuckets()) {
            std::cout << bucket.GetName() << '\n';
        }
    }

    Aws::ShutdownAPI(options);

    return 0;
}

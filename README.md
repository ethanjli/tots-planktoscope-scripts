# tots-planktoscope-scripts

Shell scripts to automatically process PlanktoScope datasets in the ToTS project

This is a set of shell scripts to automatically run the PlanktoScope segmentation routine on all PlanktoScope datasets generated in the Tale of Three Systems project on R/V Sikuliaq in June-July 2023.

## Usage

The instructions below are for the specific configurations and assumptions hard-coded into the scripts.

### Prerequisites

You will need to have a Raspberry Pi computer (henceforth called `cold-pocket-49718`) connected by USB to a WD Elements external hard drive. That hard drive should have a directory structure so that the directory with `/media/pi/Elements/tots-ps/data` has a collection of `.tar.gz` archives with names in the format `tots-ps-acq-<id>.tar.gz`, where `<id>` should not have `-results` as a suffix. Each archive should consist of a folder which would normally be generated/processed from the path `/home/pi/data/img`, holding exactly one dataset for one acquisition; thus, extracting that archive into an empty `/home/pi/data/img` directory would lead `/home/pi/data/img` to contain exactly one raw dataset following the standard PlanktoScope directory structure.

Your `cold-pocket-49718` Raspberry Pi computer will need to run the v2023.9.0-alpha.0 software, and it will also need to be connected by Ethernet cable to another Raspberry Pi computer (whose machine name is assumed by the scripts in this repository to be `regular-level-9927`) running the v2023.9.0-alpha.0 prerelease of the PlanktoScope software, but modified to only run the segmenter process in the Python backend. The `regular-level-9927` computer's dhcpcd configuration also needs to be modified to disable the eth0 static profile, so that both Raspberry Pi computers can talk to each other correctly when connected by an Ethernet cable.

If you want to upload segmentation results to a remote storage system (e.g. Google Drive folder) with path `/field_work/2023/2023-Arctic-SKQ/Data/PlanktoScope/results-preview/`, you will need to install and configure rclone with a remote named `prakashlab-googledrive`, and your `cold-pocket-49718` computer will need to have internet access.

### Installation

Download the `planktoscope` binary from https://github.com/PlanktoScope/cli/releases/download/v0.2.0/planktoscope-cli_0.2.0_linux_arm.tar.gz into `/home/pi/.local/bin` on your `cold-pocket-49718` computer. Also download the scripts from this repository into the same location on your `cold-pocket-49718` computer.

### Invocation

Just run the `tots-process-all.sh` as a command in your terminal. This will check `/media/pi/Elements/tots-ps/data` for datasets which have not yet been segmented; if all datasets have already been segmented, it will wait 60 seconds before checking again. If some dataset still needs to be segmented, it will upload the dataset to the `regular-level-9927` computer, automatically start segmentation, automatically wait for segmentation to finish, and then download the `regular-level-9927` computer's `/home/pi/data/objects` directory as a `.tar.gz` archive with a name in the format `tots-ps-acq-<id>-results.tar.gz`. It will then wait 30 seconds before checking for any other datasets which need to be segmented, and then processing another dataset, and repeating this forever.

To upload the segmentation results for a particular dataset to a remote storage system (e.g. Google Drive folder) with path `/field_work/2023/2023-Arctic-SKQ/Data/PlanktoScope/results-preview/`, just run `tots-share-results.sh tots-ps-acq-<id>.tar.gz` where `<id>` is replaced with the appropriate value. This command will also extract the segmentation results into the directory `/home/pi/results-preview/tots-ps-acq-<id>` on your `regular-level-9927` computer, so that you can also view the results locally from any device connected to the `regular-level-9927` computer's wireless AP wifi network.

## Licensing

I have chosen the following licenses in order to give away our work for free, so that you can freely use it for whatever purposes you have, with minimal restrictions while still protecting my disclaimer that this work is provided without any warranties at all. If you're using this project, or if you have questions about the licenses, I'd love to hear from you - please start a new discussion thread in the "Discussions" tab of this repository on Github or email me at lietk12@gmail.com .

### Software

Except where otherwise indicated in this repository, software files provided here are covered by the following information:

**Copyright Ethan Li**

SPDX-License-Identifier: `Apache-2.0 OR BlueOak-1.0.0`

Software files in this project are released under the [Apache License v2.0](https://www.apache.org/licenses/LICENSE-2.0) and the [Blue Oak Model License 1.0.0](https://blueoakcouncil.org/license/1.0.0); you can use the source code provided here under the Apache License or under the Blue Oak Model License, and you get to decide which license you will agree to. I am making the software available under the Apache license because it's [OSI-approved](https://writing.kemitchell.com/2019/05/05/Rely-on-OSI.html) and it goes well together with the [Solderpad Hardware License](https://solderpad.org/licenses/SHL-2.1/), which is an open hardware license used in various projects I have worked on; but I like the Blue Oak Model License more because it's easier to read and understand. Please read and understand the licenses for the specific language governing permissions and limitations.

### Everything else

Except where otherwise indicated in this repository, any other files (such as images, media, data, and textual documentation) provided here not already covered by software or hardware licenses (described above) are instead covered by the following information:

**Copyright Ethan Li**

SPDX-License-Identifier: `CC-BY-4.0`

Files in this project are released under the [Creative Commons Attribution 4.0 International License](http://creativecommons.org/licenses/by/4.0/). Please read and understand the license for the specific language governing permissions and limitations.

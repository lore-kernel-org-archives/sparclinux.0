From: Julian Calaby <julian.calaby@gmail.com>
Date: Wed, 09 Feb 2011 22:43:33 +0000
Subject: Sparc Stress Testing
Message-Id: <AANLkTi=A-kVN8Z6oaonp-8xVO3E07oHRbJaf_GW=wUGR@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

Following on from my previous emails, I've started trying to come up
with some way of repeatably stressing a system to test it's stability.

I'm using my Ultra 1e with Debian Testing as a starting point before
moving on to newer kernels (it's running a Debian patched 2.6.32) and
my plan at the moment is using the Phoronix Test Suite's [1]
linux-system benchmark as a hardware stresser.

My methodology at the moment is to:
1. Install the test suite - Phoronix provides a deb package [2] which
installs quickly - I'm using 2.8.2 at the moment, but intend to switch
to a newer version in the near future.
2. Install the dependencies - the test suite tells you what these are.
3. Install the tests. This took ~ 8 - 12 hours on my U1e as it
downloads and compiles them all from scratch, including downloading
~500 MB of data and code as well as compiling everything from Apache
to ffmpeg. If you're going to try this yourself, be aware that this
all expands out to ~1.6 GB of data. (Note that it informs you of this,
but doesn't check whether you have the disk space.)
4. Run the tests. Excluding the two that wouldn't download, there are
27 tests. It took about 10 hours of constant running to get to around
test 7, with each test taking at least 1.25 hours each.

Feel free to upload the results somewhere (PTS 2.8.2 integrates with
Phoronix Global [3]) it'd be nice to have a relative performance
metric of various kernels and systems, but, as far as I'm concerned,
this is a interesting but irrelevant side-effect. My goal with this is
to stress test the kernel and as many of it's subsystems as possible.

My results at the moment are that it locked up solid after being up
for 1 day 7.5 hours. (with the testing going on for ~24 hours) I
believe that it was doing some CPU intensive benchmarks at the time,
but given that it had already done the apache2 benchmark (which
involved running > 50 httpd instances) I'm not sure why it did it. As
it crashed this morning before I left, I have been unable to do any
proper analysis of *why* it did that. Also, my machine is headless at
the moment, and I was monitoring the serial port from a second
machine. Whilst I did get some output (two characters at a login
prompt and moving the cursor to the start of the line - usual stuff
for a kernel message) I didn't get anything usable, so hopefully the
logs will contain *something* usable. I note, however, that PTS
doesn't seem to do a great job of recording in-progress logs, so there
may not be that much to recover.

Feel free to try this out yourselves, but be aware that this will take
up a *lot* of time on slower machines. - I hope to figure out some way
to use distcc to speed up the compilation process, but given that the
testing itself takes over an hour per test on what I'd describe as a
"reasonable" system. (as in it manages packages at about the same
speed as a 1GHz P3) This will take a while - though arguably that
isn't a bad thing.

I intend to upload more detailed instructions and details to my .plan
(linked below) at some point today or tonight, so I'll let you know
when that's up.

[1] Phoronix Test Suite: http://www.phoronix-test-suite.com/
[2] Phoronix Test Suite Downloads:
http://www.phoronix-test-suite.com/?k=downloads
[3] Phoronix Global: http://global.phoronix.com/

Thanks,

-- 

Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/

From: "Art Haas" <ahaas@airmail.net>
Date: Tue, 30 Mar 2004 23:44:12 +0000
Subject: Compiling sunlance as a module
Message-Id: <20040330234412.GB5439@artsapartment.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi.

I'm still fiddling around with my configuration for my SS20, and I found
that compiling the sunlance.c file as a module has problems. When
booting up and the various init scripts are running, the eth0 interface
fails to start correctly. By doing 'modprobe sunlance' after I log in I
am able to start eth0 and things move smoothly, but I'm an curious to
find out why having this code as a module fails. Searching via Google
brought me to the following link regarding Suse-Linux:

http://lists.suse.com/archive/suse-sparc/2002-Feb/0103.html

The original poster had a problem due to compiling sunlance as a module,
and the response was "you can't do that". So, after looking around a bit
more and not finding any more info on exactly why that is true, or even
if it is still true, I seek enlightenment from the list.

The machine is now running 2.6.5-rc3 thanks to the help I've received
here, btw.

Art Haas
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822

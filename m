From: "Art Haas" <ahaas@airmail.net>
Date: Fri, 02 Apr 2004 01:30:09 +0000
Subject: CG6 Framebuffer questions
Message-Id: <20040402013009.GB23279@artsapartment.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi.

My SS20 has a few problems while running the 2.6 BK kernels with the
framebuffer display. First, the screen never goes blank, whereas when
running a 2.4 kernel it does so after several minutes of inactivity.
Second, the display gets slightly messed up when a line of text has to
wrap. What appears to happen is the final character on the line ends up
appearing over and over itself between the left side of the screen and
the first character, and the last character and the right edge of the
screen. The text in the middle of the screen is fine, it is just the
stuff outside the normal text boundary that gets the extra junk written
over and over, producing an odd looking line. Running the 2.4 kernel
there is no display corrupution when lines wrap. Lastly, running a
'make menuconfig' under 2.6 display different colors than the normal
cyan/yellow combination that are shown when a 2.4 kernel is running, or
when I use 'make menuconfig' on my intel box.

I've looked around a bit for postings regarding these issues, but have
found zilch. So, I turn to the list again. I've read the info on
'fbset', but that appears to be used primarily when the frame buffer is
displaying X stuff, and I'm just at the console. The text corruption
stuff looks like a bug somewhere, but possibly the other two problems
are configuation issues? Anyone else running things with a CG6 driver
and seeing these problems?

Art Haas
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822

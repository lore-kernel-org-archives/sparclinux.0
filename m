From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 24 May 2007 20:09:34 +0000
Subject: Linker script cleanup / consolidation
Message-Id: <20070524200934.GB1109@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Grumble.. why is this list not following usual naming scheme...
Please include all recepients listed below in replies.

	Sam

To: David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org,
	linux-sparc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

With basis in sparc64 I did a small cleanup / consolidation work.
The sparc64 lds script is by no menas the worst to look at but
a anyway a good place to start.

In the following patch serie I did:
-> Introduce a C-like indention style
-> Introduce use of PAGE_SIZE as replacement for hardcoded constant
-> Consoildate initramfs definition


While browsing the other arch lds files I saw many other smaller
items that could be consolidated but creating a define for
something like 3-5 lines was to push it too much.

If there are a number of sections that could be defined together
I would like to combine then in a common section but I do 
know too little about the linker scripts to determine this.

The other archs shall have a similar clean-up over time.
sparc64 was just a good place to start because David had
expressed that he liked the consolidation.

	Sam

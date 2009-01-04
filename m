From: David Miller <davem@davemloft.net>
Date: Sun, 04 Jan 2009 02:57:53 +0000
Subject: Re: Export reg.h to userspace
Message-Id: <20090103.185753.152342892.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090103123341.GB18259@uranus.ravnborg.org>
In-Reply-To: <20090103123341.GB18259@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Sat, 03 Jan 2009 16:56:50 -0500

> Not that gdb works sanely on sparc or anything. It really could use a
> lot of love, if you're looking to add things to your todo list. :)

What do you mean it doesn't work well?  Current CVS only fails ~80 out
of 15,000 or so tests in it's testsuite.  I ran the testsuite just the
other night.  Many of those failures are because GDB can't resolve
versioned symbols in shared libraries cleanly, it just takes the
first one it finds in the shared object, versioned of not, when
doing a symbol lookup.

That was 32-bit, and for 64-bit you have to make sure you have
set CXX and CXX_FLAGS correctly so that the C++ tests build
64-bit binaries.

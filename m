From: Peter Jones <pjones@redhat.com>
Date: Tue, 21 Mar 2006 19:54:56 +0000
Subject: Re: Switch default page size to 64k?
Message-Id: <1142970896.11485.16.camel@vroomfondel.internal.datastacks.com>
List-Id: <sparclinux.vger.kernel.org>
References: <ed9ea0040603191435t36c95a80k47d2bf4903a66811@mail.gmail.com>
In-Reply-To: <ed9ea0040603191435t36c95a80k47d2bf4903a66811@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, 2006-03-19 at 15:26 -0800, David S. Miller wrote:

> And we will not go to using different page sizes on different chips,
> we have a single sparc64 kernel image that works on all sparc64
> processor types, and after working so hard to maintain that for the
> sanity of distribution maintainers we are not moving away from that
> without a good reason.

I'm sure I'm being somewhat naive here, but how much of my eroding
sanity is actually saved here?  There are some obvious places where
userland is affected, such as mkswap, things that do raw i/o accesses
and thus need aligned pages, etc., but those already have to do the
right detection, or else they don't work with a common 32-bit userland
between sparc32 and sparc64 machines.  What's the big scary part?

I've already read your mail about the kernel source tree, and agree that
64kB as the default page size is a bad idea.  I'm just wondering which
parts of userland you expect will actually operate incorrectly, for
reasons other than OOM.

-- 
  Peter


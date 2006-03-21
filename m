From: Peter Jones <pjones@redhat.com>
Date: Tue, 21 Mar 2006 22:12:58 +0000
Subject: Re: Switch default page size to 64k?
Message-Id: <1142979178.11485.21.camel@vroomfondel.internal.datastacks.com>
List-Id: <sparclinux.vger.kernel.org>
References: <ed9ea0040603191435t36c95a80k47d2bf4903a66811@mail.gmail.com>
In-Reply-To: <ed9ea0040603191435t36c95a80k47d2bf4903a66811@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 2006-03-21 at 13:41 -0800, David S. Miller wrote:
> From: Peter Jones <pjones@redhat.com>
> Date: Tue, 21 Mar 2006 14:54:56 -0500
> 
> > I'm sure I'm being somewhat naive here, but how much of my eroding
> > sanity is actually saved here?  There are some obvious places where
> > userland is affected, such as mkswap, things that do raw i/o accesses
> > and thus need aligned pages, etc., but those already have to do the
> > right detection, or else they don't work with a common 32-bit userland
> > between sparc32 and sparc64 machines.  What's the big scary part?
> 
> Building and fielding bug reports against multiple kernels.
> That's very real, and the reason the distribution vendors try
> to minimize the number of kernel variants they have to ship
> on each platform.

Very true; I was thinking you meant your statement in a context more
directly regarding code maintenance.  But you're right, that's a very
valid concern.

-- 
  Peter


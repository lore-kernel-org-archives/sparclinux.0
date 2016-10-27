From: James Clarke <jrtc27@jrtc27.com>
Date: Thu, 27 Oct 2016 01:27:59 +0000
Subject: Re: [PATCH] sparc64: Handle extremely large kernel TSB range flushes sanely.
Message-Id: <C0F11DC7-C4F3-45F6-987E-D394A3EEB57C@jrtc27.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20161025.224442.1417439049113609110.davem@davemloft.net>
In-Reply-To: <20161025.224442.1417439049113609110.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org

> On 26 Oct 2016, at 22:02, David Miller <davem@davemloft.net> wrote:
> 
> From: James Clarke <jrtc27@jrtc27.com>
> Date: Wed, 26 Oct 2016 21:05:36 +0100
> 
>> Thanks for this, it's now compiling. I'll let you know if it works
>> within the next 24 hours.
> 
> Thanks.
> 
>> Before I forget, what do you think about the following patch? I know
>> Debian used to use the 64-bit kernel for a 32-bit sparc userland, and so
>> "Architecture: sparc" was correct, but obviously sparc64 also exists. It
>> seems more sane to make sparc64 default to "Architecture: sparc64", with
>> sparc users needing to override this with KBUILD_DEBARCH if they want
>> to, rather than providing a setup that's broken out of the box for
>> sparc64 users.
>> 
>> From: James Clarke <jrtc27@jrtc27.com>
>> Date: Wed, 26 Oct 2016 20:17:10 +0100
>> Subject: [PATCH] builddeb: Add support for sparc64
>> 
>> Signed-off-by: James Clarke <jrtc27@jrtc27.com>
> 
> I don't know.
> 
> I still personally use a 32-bit userland on my sparc64 systems because
> that is what performs the best and is what I will be using for as long
> as I possibly can.
> 
> I've actually never used this target, is this for build the kernel or
> userland components?

Yes, make pkg-deb builds kernel, firmware, headers and linux-libc packages.
By the way, the first build I made of 4.9 (using Debian’s 4.8 config as old
config) wouldn’t boot, since:

* sunvdc module needs _mcount
* sunvnet module needs _mcount and count_bits
* crc32c_sparc64 module needs _mcount and VISenter
[* raid6_pq module needs memcpy, though that’s just for a data partition]

The workaround is not to use CONFIG_MODVERSIONS, but this wasn’t at all clear
at first. This is because of d3867f0483, which moved these to being exported in
their .S.

Anyway, the new kernel is running now and being stress-tested.

James


From: William Lee Irwin III <wli@holomorphy.com>
Date: Mon, 20 Dec 2004 12:59:33 +0000
Subject: Re: [PATCH] Fix for structure declaration error
Message-Id: <20041220125933.GW771@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20041219160643.GN32704@artsapartment.org>
In-Reply-To: <20041219160643.GN32704@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Dec 19, 2004 at 10:06:43AM -0600, Art Haas wrote:
>> The patch below fixed this problem. The SMP kernel itself ultimately did
>> not link due to other problems, but as SMP on 32-bit Sparc is still broken,
>> I couldn't try and run what I'd built. Building of an SMP kernel was
>> just something to try and see if all the files would even compile, as
>> was not the case several months ago. BTW, the link error was:
>> kernel/built-in.o(.spinlock.text+0x4): In function '_write_trylock':
>> ksysfs.c: undefined reference to '_raw_write_trylock'.

On Sun, Dec 19, 2004 at 08:55:08AM -0800, William Lee Irwin III wrote:
> I'm aware of this and have pending code for it. I'll send in this
> change with the rest of the pending patches. Hopefully I can get them
> out today.

I've not wrapped up testing just yet. I should have an update out in
a couple of hours.


-- wli

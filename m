From: Julian Calaby <julian.calaby@gmail.com>
Date: Tue, 17 Jan 2012 21:51:01 +0000
Subject: Re: silo fails to build with recent ext2fs libraries
Message-Id: <CAGRGNgUFECp-mgMjmQGOycSvh6oOfNwMUgXME9bu7bhrsEV81w@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20120115140938.GA7564@wooyd.org>
In-Reply-To: <20120115140938.GA7564@wooyd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Jan 18, 2012 at 05:51, David Miller <davem@davemloft.net> wrote:
> From: David Miller <davem@davemloft.net>
> Date: Tue, 17 Jan 2012 12:56:56 -0500 (EST)
>
>> I'm looking into the rest.
>
> So just adding the stubs (or your idea, linking with libc) doesn't
> work at all.
>
> All the new features in libext2 that get linked in cause the second
> stage bootloader image to grow too large.
>
> I'll just have to extract the parts of libext2 that we actually need
> into a stripped down local copy in SILO and I guess this will make
> us immune to this issue showing up again in the future.

Would it make sense to get Grub working on Sparc so we can abandon
SILO and reduce our maintenance burden to just the Sparc-specific
parts of Grub?

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/

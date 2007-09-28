From: "Blue Swirl" <blauwirbel@gmail.com>
Date: Fri, 28 Sep 2007 14:53:48 +0000
Subject: Re: More than 4G of memory on Sparc32?
Message-Id: <f43fc5580709280753h5ece4c85mfbb1c5e93c0a07d2@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <f43fc5580709261221y47790f7en4726a74122d42191@mail.gmail.com>
In-Reply-To: <f43fc5580709261221y47790f7en4726a74122d42191@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 9/26/07, David Miller <davem@davemloft.net> wrote:
> From: "Blue Swirl" <blauwirbel@gmail.com>
> Date: Wed, 26 Sep 2007 22:21:42 +0300
>
> > Will this ever be fixed? Anybody out there with a real machine and
> > lots of memory?
>
> Since you have a qemu with >4GB support you are in the best
> position the fix this :-)

Maybe. There are other similar limits that could be explored and
fixed, for example Qemu  supports 16 CPUs on a plain Sun4m and there
are patches allowing lots of disks. But I don't see what's the point
fixing the issues if there are no real machines where removing these
limits would matter.

If I implemented in Qemu a completely new system (Sun4q?) with a
Sparc-like CPU of my own design, would you accept any patches to
support that in Linux?

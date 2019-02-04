From: Anatoly Pugachev <matorola@gmail.com>
Date: Mon, 04 Feb 2019 15:24:55 +0000
Subject: Re: [sparc64] soft lockup - CPU stuck , KGDB_TESTS_ON_BOOT
Message-Id: <CADxRZqzyQUTNA-ethJHzLQacdE+D6fx4dNpQEDU6zcc2CpGvbA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqxP8A7+8QdB5Q2df4g_OeBbARB1UAg-acaEL=mGJWr_rw@mail.gmail.com>
In-Reply-To: <CADxRZqxP8A7+8QdB5Q2df4g_OeBbARB1UAg-acaEL=mGJWr_rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Dec 19, 2018 at 5:44 PM Meelis Roos <mroos@linux.ee> wrote:
>
> > My current LDOM configuration allocated 3 cores (3x8 = 24 vcpus).
> > Tried as well with 2 vcpus and 1 vcpu. Any configuration, except 1
> > vcpu, does not boot, but single vcpu boots ok.
> >
> > Enabled the following kernel config options:
> >
> > CONFIG_KGDB_TESTS=y
> > CONFIG_KGDB_TESTS_ON_BOOT=y
> > CONFIG_KGDB_TESTS_BOOT_STRING="V1F100"
>
> For test, I enabled these options on T1000 and T5120 (both bare hardware) and it hangs here too:

just tested on 5.0.0-rc5 , still hangs / lockups.

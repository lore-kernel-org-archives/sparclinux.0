From: "Kasatkin, Dmitry" <dmitry.kasatkin@intel.com>
Date: Thu, 26 Jan 2012 22:41:59 +0000
Subject: Re: [PATCH 0/2] Fix the sparc32 mpilib build mess.
Message-Id: <CALLzPKZbruWK2LFjqOZFimSfryPGJ2c95HhePiQ7+EsU2-jBjA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20120126.173202.2207050843577467461.davem@davemloft.net>
In-Reply-To: <20120126.173202.2207050843577467461.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org

On Fri, Jan 27, 2012 at 12:32 AM, David Miller <davem@davemloft.net> wrote:
>
> The long and short of it is that the longlong.h header added by
> the mpilib code is quite old and out of date.
>
> Here I've solved the clz_tab[] multiple definition problem as
> well as the outdated udiv_qrnnd() definition, but long term
> we should probably have a more uptodate longlong.h header
> provides at include/linux/longlong.h to avoid this kind of
> stuff in the future.
>
> It's a part of the libgcc interface and therefore has no
> business being tucked down deep under lib/foo/ somewhere.

Hello,

There is newer version of longlong.h in libgcrypt.
I will definitely try it...

- Dmitry

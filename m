From: Anatoly Pugachev <matorola@gmail.com>
Date: Sat, 07 Jan 2017 12:51:04 +0000
Subject: Re: console noise after commit c1e9b3b0eea
Message-Id: <CADxRZqxRT8SH=VHJSZi66Nonx+SrU2VsY_u2dSPDJrUuU7E+uQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20160419223325.GA15852@oracle.com>
In-Reply-To: <20160419223325.GA15852@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Apr 20, 2016 at 1:33 AM, Sowmini Varadhan
<sowmini.varadhan@oracle.com> wrote:
>
> Hi Anatoly,
>
> after commit c1e9b3b0eea1 ("hwrng: n2 - Attach on T5/M5, T7/M7 SPARC CPUs")
> I get a *lot* of console noise on my T5-2, of the form:
>
> n2rng f028f21c: Selftest failed on unit 0
> n2rng f028f21c: Test buffer slot 0 [0x0000000000000000]
> n2rng f028f21c: Test buffer slot 1 [0xe63f56d6a22eb116]
> n2rng f028f21c: Test buffer slot 2 [0xe63f56d6a22eb116]
> n2rng f028f21c: Test buffer slot 3 [0xe63f56d6a22eb116]
> n2rng f028f21c: Test buffer slot 4 [0xe63f56d6a22eb116]
> n2rng f028f21c: Test buffer slot 5 [0xe63f56d6a22eb116]
> n2rng f028f21c: Test buffer slot 6 [0xe63f56d6a22eb116]
> n2rng f028f21c: Test buffer slot 7 [0xe63f56d6a22eb116]

Sowmini ,

what is your linux sysctl value for kernel.printk ?

mine is :
kernel.printk = 7       4       1       7

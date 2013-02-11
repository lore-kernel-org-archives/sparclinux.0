From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 11 Feb 2013 22:29:37 +0000
Subject: Re: [PATCH next v2] OF: convert devtree lock from rw_lock to raw spinlock
Message-Id: <CACxGe6sd1tjPYjM5MTZiRHN_PtYDsRUyZxKRxcfQx6MEUBGUyg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1359993921-18145-1-git-send-email-paul.gortmaker@windriver.com>
 <1360182656-15898-1-git-send-email-paul.gortmaker@windriver.com>
 <511585A9.9090008@gmail.com> <51194685.5010904@wwwdotorg.org>
 <51194C75.5040302@gmail.com> <CACxGe6umkZ0D2AGircEVtMfito-DWtgUBWnR15iPEDGrBGFZKA@mail.gmail.com>
 <51196ED1.9090202@gmail.com>
In-Reply-To: <51196ED1.9090202@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robherring2@gmail.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Thomas Gleixner <tglx@linutronix.de>, rt-users <linux-rt-users@vger.kernel.org>, devicetree-discuss <devicetree-discuss@lists.ozlabs.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>

On Mon, Feb 11, 2013 at 10:21 PM, Rob Herring <robherring2@gmail.com> wrote:
> On 02/11/2013 04:18 PM, Grant Likely wrote:
>> On Mon, Feb 11, 2013 at 7:54 PM, Rob Herring <robherring2@gmail.com> wrote:
>>> I found the problem. of_get_next_available_child ->
>>> of_device_is_available -> of_get_property -> of_get_property. An
>>> unlocked version of of_device_is_available is needed here.
>>
>> Oops, I had testbooted on a single core machine which would mask the
>> issue. I've crafted a fix and am posting it for review before I apply
>> it.
>>
>
> I'm in the process of applying Stephen's fix.

I didn't actually see Stephen's fix until just now, after I had
already written, posted and pushed out basically the same thing. :-)

g.

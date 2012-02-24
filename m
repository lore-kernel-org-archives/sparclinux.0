From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 24 Feb 2012 18:03:18 +0000
Subject: Re: [PATCH 1/2] irq_domain: Centralize definition of irq_dispose_mapping()
Message-Id: <CACxGe6s-ZG3bqqvXj5J-XGVh7nQ+pf5UVMsm-L+ffMX+r3QBew@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1330102448-19172-1-git-send-email-grant.likely@secretlab.ca> <4F47C9BF.10008@gmail.com>
In-Reply-To: <4F47C9BF.10008@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: David Daney <ddaney.cavm@gmail.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, "David S. Miller" <davem@davemloft.net>, Jonas Bonn <jonas@southpole.se>, sparclinux@vger.kernel.org, linux@openrisc.net

On Fri, Feb 24, 2012 at 10:32 AM, David Daney <ddaney.cavm@gmail.com> wrote:
> On 02/24/2012 08:54 AM, Grant Likely wrote:
>>
>> Several architectures define their own empty irq_dispose_mapping(). =A0S=
ince
>> the irq_domain code is centralized now, there is little need to do so.
>> =A0This
>> patch removes them and creates a new empty copy when !CONFIG_IRQ_DOMAIN =
is
>> selected.
>>
>> The patch also means that IRQ_DOMAIN becomes selectable on all
>> architectures.
>>
>> Signed-off-by: Grant Likely<grant.likely@secretlab.ca>
>> Cc: Rob Herring<rob.herring@calxeda.com>
>> Cc: "David S. Miller"<davem@davemloft.net>
>> Cc: Jonas Bonn<jonas@southpole.se>
>> Cc: sparclinux@vger.kernel.org
>> Cc: linux@lists.openrisc.net
>> ---
>> =A0arch/openrisc/include/asm/prom.h | =A0 10 +---------
>> =A0arch/sparc/include/asm/prom.h =A0 =A0| =A0 10 +---------
>> =A0include/linux/irqdomain.h =A0 =A0 =A0 =A0| =A0 =A05 ++++-
>> =A0include/linux/of_irq.h =A0 =A0 =A0 =A0 =A0 | =A0 =A04 +---
>> =A04 files changed, 7 insertions(+), 22 deletions(-)
>>
>
> There is also a definition in arch/mips/include/asm/irq.h.
>
> Probably best to get rid of that one too.

I've got a separate patch which I posted today that enables IRQ_DOMAIN
on MIPS which does indeed remove that definition.

g.

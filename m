From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 18 Mar 2010 16:24:05 +0000
Subject: Re: [V2 PATCH 06/10] of/drivers: Always use struct device.of_node to
Message-Id: <fa686aa41003180924x1b6de684w7267013afd07496@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20100318144836.21082.93040.stgit@angua>
	<20100318152238.21082.10985.stgit@angua>
	<4BA24DA8.9030309@scram.de>
In-Reply-To: <4BA24DA8.9030309@scram.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jochen Friedrich <jochen@scram.de>
Cc: linux-kernel@vger.kernel.org, michal.simek@petalogix.com, microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

On Thu, Mar 18, 2010 at 9:58 AM, Jochen Friedrich <jochen@scram.de> wrote:
> Hi Grant,
>
>> The following structure elements duplicate the information in
>> 'struct device.of_node' and so are being eliminated. =A0This patches
>> makes all readers of the following elements use device.of_node instead.
>>
>> struct dev_archdata.prom_node (sparc)
>> struct dev_archdata.of_node (powerpc)
>> struct of_device.node
>>
>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>> ---
>>
>> =A0drivers/i2c/busses/i2c-ibm_iic.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
4 ++--
>> =A0drivers/i2c/busses/i2c-mpc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 17 ++++++++-------
>
> drivers/i2c/busses/i2c-cpm.c is missing in this patch.

Good catch, Thanks.

g.

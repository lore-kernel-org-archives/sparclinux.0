From: Julian Calaby <julian.calaby@gmail.com>
Date: Wed, 14 Nov 2012 22:46:44 +0000
Subject: Re: [PATCH] drivers/of: Constify device_node->name and ->path_component_name
Message-Id: <CAGRGNgXw1c-Yt1nbkmh_WfhhCUQ6kn7bESS6EpoTSu=XQ=iR6Q@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1352932107-14782-1-git-send-email-grant.likely@secretlab.ca>
 <20121114.173304.405703188822325414.davem@davemloft.net> <CACxGe6vGVK1BQ8Zw+AH3_zSCsCLVfNENb-Qwn45tb+zwC9Mheg@mail.gmail.com>
In-Reply-To: <CACxGe6vGVK1BQ8Zw+AH3_zSCsCLVfNENb-Qwn45tb+zwC9Mheg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely@secretlab.ca>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org, benh@kernel.crashing.org

Hi Grant,

On Thu, Nov 15, 2012 at 9:42 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Wed, Nov 14, 2012 at 10:33 PM, David Miller <davem@davemloft.net> wrote:
>>
>> You're making other changes here, such as the kstrdup() stuff,
>> seperate that into another patch.
>
> It's part of the same change. The original code was allocating a
> buffer, saving the pointer in the name field and then modifying it.
> Making the code to a kstrdup() gets rid of modifying the const buffer.

You should really mention this in the commit log, maybe something like:


[PATCH] drivers/of: Constify device_node->name and ->path_component_name

Neither of these should ever be changed once set. Make them const

Also use kstrdup() instead of memcpy() so we don't attempt to modify them.

Build tested with defconfigs on ARM, PowerPC, Sparc, MIPS, x86 among
others.


Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/

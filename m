From: Ding Tianhong <dingtianhong@huawei.com>
Date: Thu, 17 Aug 2017 01:22:46 +0000
Subject: Re: [PATCH net 0/2] net: ixgbe: Use new flag to disable Relaxed Ordering
Message-Id: <ea51f2cc-49f7-3689-d503-23c56e6fe90b@huawei.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1502876507-9360-1-git-send-email-dingtianhong@huawei.com>
 <20170816.105647.341781221143669151.davem@davemloft.net>
In-Reply-To: <20170816.105647.341781221143669151.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: jeffrey.t.kirsher@intel.com, keescook@chromium.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, intel-wired-lan@lists.osuosl.org, alexander.duyck@gmail.com, netdev@vger.kernel.org



On 2017/8/17 1:56, David Miller wrote:
> From: Ding Tianhong <dingtianhong@huawei.com>
> Date: Wed, 16 Aug 2017 17:41:45 +0800
> 
>> The new flag PCI_DEV_FLAGS_NO_RELAXED_ORDERING has been added
>> to indicate that Relaxed Ordering Attributes (RO) should not
>> be used for Transaction Layer Packets (TLP) targeted toward
>> these affected Root Port, it will clear the bit4 in the PCIe
>> Device Control register, so the PCIe device drivers could
>> query PCIe configuration space to determine if it can send
>> TLPs to Root Port with the Relaxed Ordering Attributes set.
>>
>> The ixgbe driver could use this flag to determine if it can
>> send TLPs to Root Port with the Relaxed Ordering Attributes set.
> 
> I'll let the Intel guys pick this up.
> 
Thanks David, but I am not sure when the Intel guys would take over,
just Alex has replied, so I will release a new version according Alex's
suggestion.

> .
> 


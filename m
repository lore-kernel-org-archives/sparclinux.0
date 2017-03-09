From: David Miller <davem@davemloft.net>
Date: Thu, 09 Mar 2017 05:59:51 +0000
Subject: Re: [PATCH net-next 0/5] sunvnet: better connection management
Message-Id: <20170308.215951.1257204853862874733.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1488842132-512058-1-git-send-email-shannon.nelson@oracle.com>
        <80e05f39-ea92-bfdf-b7d6-2cee47c8bab6@oracle.com>
In-Reply-To: <80e05f39-ea92-bfdf-b7d6-2cee47c8bab6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: shannon.nelson@oracle.com
Cc: netdev@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Wed, 8 Mar 2017 15:04:45 -0800

> On 3/6/2017 3:15 PM, Shannon Nelson wrote:
>> These patches remove some problems in handling of carrier state
>> with the ldmvsw vswitch, remove  an xoff misuse in sunvnet, and
>> add stats for debug and tracking of point-to-point connections
>> between the ldom VMs.
> 
> Further testing shows a problem in one of the patches, so there will
> be a V2 coming.

Ok.

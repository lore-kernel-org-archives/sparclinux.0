From: Thomas Tai <thomas.tai@oracle.com>
Date: Fri, 11 Nov 2016 02:24:51 +0000
Subject: Re: [PATCH] sparc64: Fix find_node warning if numa node cannot be found
Message-Id: <77d8917d-1e97-3380-cb54-60dff957f2e3@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1478189941-97334-1-git-send-email-thomas.tai@oracle.com>
In-Reply-To: <1478189941-97334-1-git-send-email-thomas.tai@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On 11/10/2016 7:48 PM, David Miller wrote:
> From: Thomas Tai <thomas.tai@oracle.com>
> Date: Thu,  3 Nov 2016 09:19:01 -0700
>
>> When booting up LDOM, find_node() warns that a physical address
>> doesn't match a NUMA node.
>>
>> WARNING: CPU: 0 PID: 0 at arch/sparc/mm/init_64.c:835
>> find_node+0xf4/0x120 find_node: A physical address doesn't
>> match a NUMA node rule. Some physical memory will be
>> owned by node 0.Modules linked in:
>   ...
>> It is because linux use an internal structure node_masks[] to
>> keep the best memory latency node only. However, LDOM mdesc can
>> contain single latency-group with multiple memory latency nodes.
>>
>> If the address doesn't match the best latency node within
>> node_masks[], it should check for an alternative via mdesc.
>> The warning message should only be printed if the address
>> doesn't match any node_masks[] nor within mdesc. To minimize
>> the impact of searching mdesc every time, the last matched
>> mask and index is stored in a variable.
>>
>> Signed-off-by: Thomas Tai <thomas.tai@oracle.com>
>> Reviewed-by: Chris Hyser <chris.hyser@oracle.com>
>> Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
> Applied.
Thank you David for your time to review and apply the patch.
Thomas

From: Yinghai Lu <yinghai@kernel.org>
Date: Tue, 25 Sep 2012 16:33:20 +0000
Subject: Re: [PATCH 20/29] PCI, sparc: kill pci_find_next_bus
Message-Id: <CAE9FiQXKe8okPLfRdjUz-+f3A7zN94tzVpq3vN8eBM+SeyLZnA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
	<1348561590-28067-21-git-send-email-yinghai@kernel.org>
	<20120925084004.GA6652@wooyd.org>
In-Reply-To: <20120925084004.GA6652@wooyd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jurij Smakov <jurij@wooyd.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

On Tue, Sep 25, 2012 at 1:40 AM, Jurij Smakov <jurij@wooyd.org> wrote:
> On Tue, Sep 25, 2012 at 01:26:21AM -0700, Yinghai Lu wrote:
>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: sparclinux@vger.kernel.org
>> ---
>>  arch/sparc/kernel/pci.c |    6 ++++--
>>  1 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
>> index acc8c83..70d8c16 100644
>> --- a/arch/sparc/kernel/pci.c
>> +++ b/arch/sparc/kernel/pci.c
>> @@ -997,11 +997,13 @@ static void __devinit pci_bus_slot_names(struct device_node *node,
>>
>>  static int __init of_pci_slot_init(void)
>>  {
>> -     struct pci_bus *pbus = NULL;
>> +     struct pci_host_bridge *host_bridge = NULL;
>> +     struct pci_bus *pbus;
>>
>> -     while ((pbus = pci_find_next_bus(pbus)) != NULL) {
>> +     for_each_pci_host_bridge(host_bridge) {
>>               struct device_node *node;
>>
>> +             pbus = hot_bridge->bus;
>
> Should this be 'host_bridge' and not 'hot_bridge'?

fixed.

Thanks

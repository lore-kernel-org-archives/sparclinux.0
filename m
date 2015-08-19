From: Yinghai Lu <yinghai@kernel.org>
Date: Wed, 19 Aug 2015 05:30:36 +0000
Subject: Re: Aw: A500 boot crash in 4.2.0-rc3-00246-g763e326
Message-Id: <CAE9FiQW9hjDe2NBEfwQqcVZoJKqDjKT1P=7FcGjhVrF7wQW9+g@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.11.1507260929000.30065@math.ut.ee>
	<trinity-122a736f-3aac-4830-afc5-2abcd91792ea-1439820380917@3capp-gmx-bs71>
	<trinity-5720bef8-5a4c-4465-b9eb-622daaef650a-1439902901415@3capp-gmx-bs02>
	<alpine.LRH.2.20.1508182141200.24742@math.ut.ee>
	<55D38BE6.6080302@gmx.de>
	<CAE9FiQVUUN-SLO0U4G5CC6MEoXfb=bGd+f3bRgQprtaMHjsvpA@mail.gmail.com>
	<alpine.LRH.2.20.1508190747360.5154@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1508190747360.5154@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Meelis Roos <mroos@linux.ee>
Cc: Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, James Bottomley <James.Bottomley@hansenpartnership.com>

On Tue, Aug 18, 2015 at 9:48 PM, Meelis Roos <mroos@linux.ee> wrote:
>> On Tue, Aug 18, 2015 at 12:47 PM, Helge Deller <deller@gmx.de> wrote:
>>
>> Then we should change to
>>
>> config PCI_BUS_ADDR_T_64BIT
>>        def_bool y if (ARCH_DMA_ADDR_T_64BIT || SPARC64)
>>        depends on PCI
>
> Why SPARC64? The problem happened on parisc.
>

so will not set PCI_BUS_ADDR_T_64BIT for parisc.

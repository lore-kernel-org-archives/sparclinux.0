From: bert hubert <ahu@ds9a.nl>
Date: Thu, 21 Oct 2004 18:24:10 +0000
Subject: Re: [2.6.9] headless SMP ultra2 has grave serial problem which lock up the box
Message-Id: <20041021182410.GA31577@outpost.ds9a.nl>
List-Id: <sparclinux.vger.kernel.org>
References: <20041021111317.GB21579@outpost.ds9a.nl>
In-Reply-To: <20041021111317.GB21579@outpost.ds9a.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Oct 21, 2004 at 10:49:04PM +0800, Richard Chan wrote:
> Is your system using the su driver by any chance? - I have a patch just 
> posted to the list

Sadly, no, this is an SBUS system:

zs2 at 0x000001fff1000004 (irq = 12,7e8) is a SunZilog
zs3 at 0x000001fff1000000 (irq = 12,7e8) is a SunZilog
ttyS0 at MMIO 0x0 (irq = 7467840) is a SunZilog
ttyS1 at MMIO 0x0 (irq = 7467840) is a SunZilog

However, this looks a bit like the problem you reported. Might the same bug
exist here?

Thanks!

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO

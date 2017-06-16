From: David Miller <davem@davemloft.net>
Date: Fri, 16 Jun 2017 16:40:48 +0000
Subject: Re: [v1 0/2] Early boot timestamp fixes
Message-Id: <20170616.124048.346630084778753679.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1497537659-419752-1-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1497537659-419752-1-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 16 Jun 2017 13:17:01 +0100

> Right. I don't see a stick-frequency in a DT from a real Ultra 5, so I
> presume that this is specific to IIe?

Right, Ultra-5 is IIi which uses plain %tick.

IIe uses a special system tick based tick register in I/O space and
therefore has to have a stick-frequency.

Looking in the prtconfs GIT repo, we see:

[davem@dhcp-10-15-49-210 net-next]$ egrep IIe ../prtconfs/*
grep: ../prtconfs/mdesc: Is a directory
../prtconfs/netrat1_200:    banner-name: 'Netra T1 200 (UltraSPARC-IIe 500MHz)'
../prtconfs/netrat1_200:        name: 'SUNW,UltraSPARC-IIe'
../prtconfs/netrax1:    banner-name: 'Sun Netra X1 (UltraSPARC-IIe 500MHz)'
../prtconfs/netrax1:        name: 'SUNW,UltraSPARC-IIe'
../prtconfs/sb100:    banner-name: 'Sun Blade 100 (UltraSPARC-IIe)'
../prtconfs/sb100:        name: 'SUNW,UltraSPARC-IIe'
../prtconfs/v100:    banner-name: 'Sun Fire V100 (UltraSPARC-IIe 500MHz)'
../prtconfs/v100:        name: 'SUNW,UltraSPARC-IIe'
../prtconfs/v120:    banner-name: 'Sun Fire V120 (UltraSPARC-IIe 500MHz)'
../prtconfs/v120:        name: 'SUNW,UltraSPARC-IIe'
[davem@dhcp-10-15-49-210 net-next]$

and in 'sb100' we have:

    stick-frequency:  0054c563

in the root node of the system.


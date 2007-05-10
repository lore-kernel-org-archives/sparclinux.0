From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Date: Thu, 10 May 2007 14:05:14 +0000
Subject: Re: iptables throws unknown error - suspecting 32/64 compat issue
Message-Id: <Pine.LNX.4.61.0705101605020.32349@yvahk01.tjqt.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0705100812440.32349@yvahk01.tjqt.qr>
 <Pine.LNX.4.61.0705100832050.32349@yvahk01.tjqt.qr> <46431C0D.5080507@trash.net>
 <Pine.LNX.4.61.0705101521570.32349@yvahk01.tjqt.qr> <464325EA.8040303@trash.net>
In-Reply-To: <464325EA.8040303@trash.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Patrick McHardy <kaber@trash.net>
Cc: sparclinux@vger.kernel.org, Netfilter Developer Mailing List <netfilter-devel@lists.netfilter.org>


On May 10 2007 16:02, Patrick McHardy wrote:
>> 
>> A lot ... as far as the filter table and sshcheck is concerned,
>> 
>> iptables -N sshcheck;
>> iptables -A sshcheck -m recent --name sshcheck --seconds 60 --update -j DROP;
>> iptables -A sshcheck -m hashlimit --hashlimit-name sshcheck \
>>         --hashlimit-mode srcip --hashlimit 4/min --hashlimit-burst 4 \
>>         -j RETURN;
>> iptables -A sshcheck -m recent --name sshcheck --set -j DROP;
>
>Did you get an "invalid size" message in the ringbuffer before the oops?

Now that you mention it, yes:

ip_tables: conntrack match: invalid size 80 != 72


	Jan
-- 

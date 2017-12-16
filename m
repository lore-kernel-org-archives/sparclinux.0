From: Jan Engelhardt <jengelh@inai.de>
Date: Sat, 16 Dec 2017 00:57:46 +0000
Subject: Re: n2_crypto gets a BUG() triggered on T5240
Message-Id: <nycvar.YFH.7.76.1712151444211.6644@n3.vanv.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <nycvar.YFH.7.76.1712110214220.28416@n3.vanv.qr>
In-Reply-To: <nycvar.YFH.7.76.1712110214220.28416@n3.vanv.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On Monday 2017-12-11 20:20, David Miller wrote:
>
>> With the current Debian sid system (2-3 days old) running the 4.14.2,
>> loading the n2_crypto module causes a BUG() to get triggered. The
>> system is a T5240 and the problem is reliably repeatable in case I
>> should try some suggestions, patches, or if I need to provide more
>> information. On a T5120, loading n2_crypto does not lead to this
>> issue.
>> 
>> Trimmed dmesg, kept the lines which seem relevant.
>
>I can't see any recent changes to the driver which would cause this.
>Please reproduce with the current upstream kernel and bisect.

Since there is no known good version as of yet, I have randomly 
samples some versions, among them

 - 032b4cc8ff84490c4bc7c4ef8c91e6d83a637538 (4.15-rc3+)
 - 4.10.0
 - 4.9.69
 - 4.8.17
 - anything older than 4.8-rcN yields various compile errors
   (compiler too new / etc.) and I'd have to cherry-pick a lot.

All of these crash when n2_crypto gets loaded.
...
Meanwhile I have a fix that git-send-email will send as a reply hereto.

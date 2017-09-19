From: Eric Saint Etienne <eric.saint.etienne@oracle.com>
Date: Tue, 19 Sep 2017 06:43:51 +0000
Subject: Re: [PATCH] sparc64: Expose mdesc to sysfs
Message-Id: <ba65ec2f-cebb-f9a8-3fe6-c6547f053b11@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
In-Reply-To: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


> I still stand by my decision, sorry.
I am sorry for every Sparc users because it was a chance for them to 
easily explore and use machine description without having to install an 
external tool and a scripting language plus dependencies (potentially a 
lot of dependency). Users may also not know about /dev/mdesc whereas a 
mere "grep -ri cache /sys" would be fruitful.

Also mdesc is root accessible only. Exposing all or even just a 
selection of machine description nodes to users via sysfs provides them 
with the visibility of for instance TLBs and Caches (number, size, and 
more importantly how they are organized in the processor).

-eric

From: Joe Ciccone <jciccone@gmail.com>
Date: Fri, 10 Feb 2006 21:03:09 +0000
Subject: Silo 1.4.10
Message-Id: <43ECFF8D.7050801@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1136175018.27583.50.camel@grayson>
In-Reply-To: <1136175018.27583.50.camel@grayson>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I have been working on a patch for silo that would enable me to build it in a pure64 bit enviornment. The patch is of my current working tree. The .b files build properly with this patch, It creates a static libext2fs that I put together myself and then uses that instead of the system libext2fs library which is only available in 64bit in this setup. The loaders are built 32bit and the rest of the programs are built 64bit. This is done with a modification to Rules.make by creating a CC (for host tools) and CC-SILO (for always 32bit parts). This setup relies on the fact that you have a working elftoaout binary, this was discussed earlier on this list, if you would like me to provide the patch please let me know. The include directory after this patch is applied is so large because I have copied headers from my 32bit build. CC-SILO is instructed not to use any headers from the system. This fixes and issue in the building of the .b files, which should have never included any of the system headers in the first place. I think I've traced down the problem to silo.c because before I run silo -f the .b files from my successful installation are identical to the loaders in this setup. When the table in the top of second.b is generated with silo -f, it doesn't seem to be right. I have one request, Don't say silo doesn't work on 64bit only systems. I am looking for some assistance in fixing this issue. The patch I have attached is a Major head start for anyone who has tried this in the past. I apreciate any help I can get on making this work, I've spent a lot of time on this already but I don't understand the inner workings of the silo program.

The Silo-1.4.10 patch is http://www.crazyeyesoft.com/Silo-1.4.10-fixes-2.patch



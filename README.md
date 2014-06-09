# Puppet in a Continuous Delivery Environment

## Outline

1. What is Continuous Deployment (CD)? [SLIDE 2]
   1. CD is a methodology that reduces the length of feedback cycles for the teams involved in developing and releasing software by introducing automation to the error prone manual stages. [SLIDE 3]
   2. A CD Pipeline is a name for the system that brings software through its lifecycle. This normally begins with pre-commit testing and continues through commit testing, packaging of the artifact, automated acceptance testing, deployment to TEST, deployment to STAGE, and deployment to PROD


   3. What problems does CD address? [SLIDE 4]
      1. Complex, manual, risky release processes [SLIDE 5]
         1. Done differently every time
         2. Loosely organized
            1. Various teams completing different tasks at different times
            2. Not exactly 'clockwork' as time between steps varies
         3. Forgetfulness
         4. Negated by
            1. Automating the complex parts
               1. The scripts used to do this, no matter how crappy, at least do it the same time, every time and function as a living document of the release process
               2. If automating the release process sounds completely insane, then begin with baby steps. Write strict, precise, unambiguous documentation around the project. Then once that process is being followed, begin automating it piece by piece.
            1. Bringing the pain forward
               1. If something hurts, do it more often.
               2. Repeating the process more frequently normally will drive us to fix the broken parts that will benefit more than just the one broken process.
               3. If the process is unfixable, doing it more often will at least allow one to get good at it and figure out the ins and outs of the process more quickly (and hopefully documenting it).
      1. Large size releases [SLIDE 5]
         1. Longer time between releases == bigger releases
         2. The bigger the release is, the more problematic it can be
            1. Increased complexity decreases the ability to comprehend what exact changes are going into production
            2. Error are more easily overlooked in a 100k line diff
            3. The larger the amount of changing code, the harder it is to narrow down the location of a non-functional (performance, etc..) bug in the codebase
      1. Siloing of responsibilities (anti-collaboration) [SLIDE 5]
         1. All too often this siloing creeps into the release process. Does something like this sound familar?
            1. Code is “feature complete” for the dev team. They check it in and pass it to QA at or near the end of the sprint.
            2. QA begins testing. Development moves on to the next feature.
            3. A few days later, a long running regression suite fails and QA finds a bug in the feature that the development team has committed.
            4. Now dev has moved on, their personal development environment is setup to work on the new feature (or possibly even a different product), the TEST environment has changed significantly due to all the dev teams moving on to the new feature.
            5. Dev has to then rollback their environment, address the bug, and resubmit it to QA. Unfortuntately this happens on release day when codefreeze was the Thursday before and so now code that was hastily put together is being thrown into STAGE and PROD with less testing than the well thought out code that was written earlier.
         1. Not everyone is on the same page with the release
            1. Are we releasing right now?
            2. What are those pages?
            3. Did the data-migration get run?
            4. Which data-migration?
      1. Time to PROD for a feature or bugfix [SLIDE 5]
         1. Often a feature can take years to get into production. What if it were days or hours?
         2. Bugfixes benefit from the reduced time to PROD as well.
      1. Manual labor [SLIDE 5]
         1. Does anyone here like doing the same thing 3 times?
         2. What if there is a 1 in 3 chance of bringing down production with your name being the one tied to ‘Upgrading production now’ in release chat?


1. Why would one choose CD? [SLIDE 6]
   1. Benefits to developers [SLIDE 7]
      1. Increased transparency to see what everyone is working on and align their timelines appropriate.
      2. Reduced feedback cycle [SLIDE 7]
         1. Know tests are broken right away and able to fix
      1. More enjoyment (less breaking things) [SLIDE 7]
      2. Higher quality code [SLIDE 7]
         1. Automated testing covering a lot more
         2. Able to ship to QA with higher confidence
   1. Benefits to business types [SLIDE 8]
      1. Increased transparency into how the product is moving along [SLIDE 8]
         1. More accurate forecasts
      1. Better time to feature delivery [SLIDE 8]
      2. More accurate estimations on project timelines [SLIDE 8]
      3. Abilility to group fully tested, fully functional features into a release [SLIDE 8]
         1. with the addition of feature flags
   1. Benefits to QA [SLIDE 9]
      1. Increased transparency to see how features are coming along and how tests are being developed for the code [SLIDE 9]
      2. Many gates they can close based on automated reports [SLIDE 9]
      3. No longer the bad guy [SLIDE 9]
      4. Ability to share accountability of quality with the development teams [SLIDE 9]
      5. More time to focus on testing that cannot be automated [SLIDE 9]
      6. Automating out the shittiest part of the work (repetitive, error prone) [SLIDE 9]
   1. Benefits to us (DevOps types) [SLIDE 10]
      1. Increased transparency to see if someone is pushing up a turd that will be waking us up every night [SLIDE 11]
      2. Better application to maintain [SLIDE 11]
      3. Less on-call alerts due to stupid bugs [SLIDE 11]
      4. More insight into the various processes in software development [SLIDE 11]
      5. Higher quality, cleaner enviornments because things that should not be making it in are not [SLIDE 11]


1. What are some of the guidelines with CD? [SLIDE 12]
   1. Very rigid process. The entire team must be on board as it requires dedication to the process in order to achieve success [SLIDE 13]
      1. There cannot be an attitude of polishing turds and sliding them in under the radar. That type of behaviour will easily subvert the objectives of a project like this.
   2. First priority is to fix the builds. Having a broken build in the system is a major problem with this process and will stop all development. Keeping builds working must be held as the highest of priorities. [SLIDE 13]
   3. Proper configuration management is critical to the success of the CD Pipeline. If an environment cannot be repeatedly reproduced, it is hard to glean the assurance one needs from the CD pipeline. Handcrafted works of art need to be automated before they can consider a CD pipeline [SLIDE 13]
      1. This can be addressed by adjusting the scope of the environment that needs to be spun up. Consider starting with a component of your software that runs in a less complex environment and begin automating that. Eventually you can move on to more and more complex automation around the environment. Incremental releases are good
  4. No Cheating! [SLIDE 13]
      1. Subverting the process can be easily done and so it is important to have full team buy-in to avoid people skipping the process.


1. The components of a CD Pipeline [SLIDE 14]
   1. The components
      1. Version control [SLIDE 15]
         1. Code
         2. Configuration Management
      1. Configuraton management [SLIDE 16]
         1. Puppet is an example of CM
         2. Provides everything that defines an environment
           1. The binary/package used should be the same in any enviornment with only the configuration management defining the differences
         3. CM is the foundatation for everything. If we cannot replicate an enviornment, then we cannot automate the deploy.  
      1. Build server [SLIDE 17]
         1. Replicate prod like env with CM + orchestration
         2. Build software
         3. Run unit tests
         4. Run automated acceptance tests
         5. Deploy software to STAGE
      1. Manual test phase [SLIDE 18]
        Now that QA has been relieved of their duty to run manual test suites over and over again, they can focus on more advanced items that are far harder to provide automation for [SLIDE 18]
         1. Showcasing
         2. Manual acceptance testing
            1. Usability
            2. Meet requirments?
         1. Exploratory testing
      1. Orchestration and push button releases to PROD [SLIDE 19]
         1. Should be able to roll forward and back
         2. Ideally be able to deploy any version of the application to any environment
      1. Metrics [SLIDE 20]
         1. Very important to see behavior over time
         2. Examples

1. Configuration management with Puppet in a CD Pipeline [SLIDE 21]
   1. Where Puppet excels [SLIDE 22]
      1. Maintaining state
      2. It has built PROD already
      3. Doing what it does
   1. Where puppet falters [SLIDE 23]
      1. Dealing with ephemeral hosts [SLIDE 23]
         1. Hosts that come and go do not neccessarily jive with puppet’s model of certificate signing. I have yet to see a super elegant solution that securely allows a node to joing a puppet master and then dissappear again when terminated while keeping the signed certificate list under 1,000,000
      1. Bootstrapping [SLIDE 23]
         1. Puppet needs it’s daemon to be on the machine and running in order to configure it. While there are some solutions out there to address this (Foreman, Razor) Puppet was not designed to bootstrap itself.
      1. Orchestration [SLIDE 23]
         1. Creation of resources via API
            1. standing up ec2 nodes
         1. Running a sequence of events across a group of nodes in real-time
         2. Flipping ELBs to a new version
         3. Creating complex infrastructures from scratch, via API, idempotently, with relational attributes
            1. Standing up a set of security groups with their ndoes
      1. Strongly ordered operations [SLIDE 23]
         1. While puppet allows for (and recommends) the use of chaining arrows, Requires, Befores, and other methods of ordering, it still seems like working against the grain when you just want to run 10 commands in order (like when compiling something from source) and be idempotent about it.
      1. Running processes that need to be done from multiple machines [SLIDE 23]
         1. Go to machine a and run `yum update -y`
         2. Go to machine b and run `./do_data_migration.sh`
         3. Hit the AWS API and run `switch backends on ELB1 to new nodes`



   1. What tools can supplement Puppet to fill in the gaps? [SLIDE 24]
      1. Ansible [SLIDE 25]
         1. Needs only SSH (and sudo) to operate [SLIDE 26]
         2. Can interact with various APIs and host types
            1. AWS
            2. Rackspace
            3. GCE
            4. OpenStack
            5. DigitalOcean
            6. Linode
            7. etc…
            8. SSH
         1. Is strongly ordered by nature [SLIDE 26]
         2. Very lightweight syntax (YAML) [SLIDE 26]
         4. Can delegate tasks to other hosts than where it is being run [SLIDE 26]
            1. Adding and removing hosts from a puppet master
         5. Can be hard to put a gui on [SLIDE 27]
         6. Can be expensive if you need to use the paid version


         1. Custom applications
         1. Deepthought
            1. uses Rails + fog
         1. Various other projects
            1. Normally use 
1. Hybrid solutions that revolve around puppet
   1. AWS - Ansible for orchestration
      1. Deploy a puppet master
      2. Deploy an ntp server to aws
         1. Spin up security group
         2. Spin up node in EC2
         3. Bootstrap node
         4. Delegate cert signing to puppetmaster
   1. AWS - Headless Puppet + AWS
   2. Puppet tree - Jenkins + Puppet + Merge requests

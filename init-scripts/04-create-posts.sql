-- 04-create-posts.sql
CREATE OR REPLACE FUNCTION get_random_title_for_user(username TEXT) RETURNS TEXT AS $$
DECLARE
    titles TEXT[];
BEGIN
    CASE username
        WHEN 'emmathompson' THEN
            titles := ARRAY[
                'Why Reading in the Digital Age Still Matters',
                'Finding Stories in Everyday Moments',
                'The Art of Building Online Communities',
                'Sunset Chasing: More Than Just Pretty Pictures',
                'How Coffee Fuels Creativity',
                'Digital Storytelling: A Guide for Beginners',
                'Community Building Through Shared Stories',
                'The Power of Written Connection',
                'Balancing Digital Life with Real-World Experiences',
                'Creating Meaningful Content in a Fast-Paced World'
            ];
        WHEN 'jameschen' THEN
            titles := ARRAY[
                'Bridging Music and Code: My Journey',
                'Clean Code Principles for Creative Minds',
                'How Music Improves Your Coding',
                'Building Scalable Systems: Lessons Learned',
                'From Backend to Bass Line: Tech and Music',
                'Microservices vs Monoliths: A Practical Guide',
                'The Rhythm of Good Software Design',
                'Why Every Developer Should Learn an Instrument',
                'Architecture Patterns in Code and Music',
                'Open Source Contributions: Getting Started'
            ];
        WHEN 'sofiarod' THEN
            titles := ARRAY[
                'Hidden Gems: Off the Beaten Path in Southeast Asia',
                'Street Food Stories: A Journey Through Local Flavors',
                'Photography Tips for Travel Storytelling',
                'Behind the Lens: My Experience with National Geographic',
                'Cultural Photography: Ethics and Practice',
                'From Markets to Mountains: A Photographer''s Journey',
                'The Art of Travel Documentation',
                'Food Photography: Capturing Culture Through Cuisine',
                'Adventures in Remote Photography',
                'Visual Storytelling: Beyond the Perfect Shot'
            ];
        -- Continuation of the CASE statement in get_random_title_for_user function
        WHEN 'lucaspatel' THEN
            titles := ARRAY[
                'The Evolution of Game Design: 2024 Perspective',
                'Creating Immersive Gaming Experiences',
                'Indie Game Development: Lessons Learned',
                'Balancing Creativity and Technical Constraints',
                'The Role of AI in Modern Game Design',
                'Building Engaging Game Mechanics',
                'From Concept to Console: Game Development Journey',
                'The Psychology of Player Engagement',
                'Pixel Art in Modern Gaming',
                'Game Design Principles for Non-Gaming Applications'
            ];
        WHEN 'oliviakim' THEN
            titles := ARRAY[
                'Minimalist UX: Less is More',
                'The Psychology of Color in Digital Design',
                'Creating Human-Centered Digital Experiences',
                'Plant Care Tips for Busy Designers',
                'Sustainable Design Practices',
                'The Art of Visual Hierarchy',
                'Balancing Aesthetics and Functionality',
                'My Journey from Visual Art to UX Design',
                'Design Systems: Building for Scale',
                'The Role of White Space in Modern Design'
            ];
        WHEN 'marcusand' THEN
            titles := ARRAY[
                'Startup Lessons: Year One',
                'Innovation in the Age of AI',
                'Building a Tech Company with Purpose',
                'Leadership Lessons from the Basketball Court',
                'Mindfulness in Entrepreneurship',
                'The Future of Tech Ventures',
                'Balancing Growth and Culture',
                'From Idea to Implementation: Startup Journey',
                'Tech Innovation: Beyond the Buzzwords',
                'Building Teams in the Remote Era'
            ];
        WHEN 'aishahsn' THEN
            titles := ARRAY[
                'Climate Action: Small Changes, Big Impact',
                'Sustainable Living in Urban Spaces',
                'Research Findings: Urban Environmental Solutions',
                'The Future of Sustainable Cities',
                'Cat Care and Environmental Responsibility',
                'Breaking Down Environmental Science',
                'Social Justice in Environmental Work',
                'Urban Farming Initiatives: Results and Insights',
                'Reducing Carbon Footprint: Practical Steps',
                'Environmental Education: Making It Accessible'
            ];
        WHEN 'gabsantos' THEN
            titles := ARRAY[
                'The Intersection of Code and Creativity',
                'AI Art: Exploring New Possibilities',
                'Creative Coding: Getting Started',
                'Digital Art in the Age of AI',
                'Building Interactive Art Installations',
                'The Role of Algorithms in Creative Expression',
                'Coffee and Code: Perfect Pairing',
                'Generative Art: Process and Results',
                'Making Art with Neural Networks',
                'The Future of Digital Creative Expression'
            ];
        WHEN 'isabellan' THEN
            titles := ARRAY[
                'Sustainable Fashion: Beyond the Trends',
                'Vintage Fashion in Modern Wardrobes',
                'Eco-Conscious Collection: Behind the Scenes',
                'The Future of Sustainable Style',
                'Upcycling: Fashion with Purpose',
                'Building a Conscious Wardrobe',
                'Vintage Hunting: Tips and Tricks',
                'Sustainable Materials in Fashion',
                'The Art of Timeless Style',
                'Fashion Revolution: Small Changes, Big Impact'
            ];
        WHEN 'alexwright' THEN
            titles := ARRAY[
                'Urban Spaces: Designing for Community',
                'Sustainable Architecture in Practice',
                'The Future of City Planning',
                'Cycling and Urban Design',
                'Photography in Architecture',
                'Merging Nature with Urban Design',
                'Modern Solutions for Historic Buildings',
                'Creating Spaces That Connect',
                'The Role of Light in Architecture',
                'Sustainable Materials in Modern Building'
            ];

    END CASE;
    
    RETURN titles[1 + floor(random() * array_length(titles, 1))];
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_random_content_for_user(username TEXT) RETURNS TEXT AS $$
DECLARE
    contents TEXT[];
BEGIN
    CASE username
        WHEN 'emmathompson' THEN
            contents := ARRAY[
                'In an age where screens dominate our lives, the importance of meaningful storytelling has never been greater. 📱✨

As a digital storyteller, I''ve observed how our reading habits have evolved, yet the core desire for connection remains unchanged. Here''s what I''ve learned about creating engaging content in the digital age:

1. Authenticity matters more than perfection
2. Stories create communities
3. Digital doesn''t mean impersonal

What are your thoughts on digital storytelling? How do you maintain authentic connections in the digital space? 💭',

                'Today''s sunset reminded me why I fell in love with storytelling. There''s something magical about capturing moments that unite people across screens and distances. ☀️

I''ve been reflecting on how we can better utilize digital platforms to create meaningful connections. Here are some insights from my recent community building efforts:

• Engagement over metrics
• Quality conversations matter
• Shared experiences build stronger bonds

Would love to hear your sunset stories and how you find meaning in digital spaces! 🌅',

                'Coffee shops have become more than just places to grab a drink - they''re creative hubs where stories begin. ☕️

Recently, I''ve been exploring how these spaces influence our digital narratives. Some observations:

- The ambient atmosphere enhances creativity
- Random encounters spark story ideas
- Community happens naturally

What''s your favorite spot for creative work? How does environment influence your storytelling? 💫'
            ];
        WHEN 'jameschen' THEN
            contents := ARRAY[
                'The parallels between coding and music composition have always fascinated me. 🎵💻

Today, I want to share how my background in music has influenced my approach to software development:

1. Rhythm and Flow in Code Structure
2. Harmony in System Architecture
3. Improvisation in Problem Solving

Both domains require:
• Pattern recognition
• Creative problem-solving
• Attention to detail
• Understanding of structure

What unexpected combinations influence your coding style? 🤔',

                'Just wrapped up a major refactoring project, and it reminded me of rehearsing with a band. 🎸

Key lessons learned:
- Small improvements compound
- Team synchronization is crucial
- Testing is like sound check
- Documentation is your sheet music

The project successfully reduced our codebase by 30% while improving performance.

Tech stack:
• Node.js
• React
• PostgreSQL
• Redis

What''s your approach to maintaining clean code? 🚀',

                'Building scalable systems is like composing a symphony - every component needs to work in harmony. 🎼

Recent project insights:

1. Microservices Architecture
- Independent deployment
- Isolated scaling
- Clear boundaries

2. Performance Optimization
- Caching strategies
- Load balancing
- Async processing

What''s your preferred architecture for large-scale applications? 💭'
            ];
        WHEN 'sofiarod' THEN
            contents := ARRAY[
                'Just returned from a month-long photography expedition in Southeast Asia, and I''m still processing all the incredible moments captured through my lens. 📸

Highlights from the journey:
• Dawn at Angkor Wat
• Street markets in Hanoi
• Hidden beaches in Thailand

Photography tip: The best stories often happen in the in-between moments, when you''re not looking for them. 

What''s your most memorable travel photography moment? 🌏✨',

                'Food tells the story of a culture better than any guidebook. 🍜

Today''s photo essay explores the street food scenes of Bangkok:

1. Morning markets bustling with life
2. Generations of family recipes
3. The art of presentation

Photography settings:
- Early morning light
- 35mm f/1.8
- Natural compositions

What food has told you the best story during your travels? 🌮📸',

                'Excited to share that my photo series "Markets of Asia" will be featured in next month''s National Geographic issue! 🎉

Behind the scenes of the shoot:
• 4:00 AM market arrivals
• Countless cups of local coffee
• Stories shared in broken English
• Trust built through time and respect

Remember: Cultural photography is about connection first, composition second. 

What stories do you dream of capturing? 🌅'
            ];
        WHEN 'lucaspatel' THEN
            contents := ARRAY[
                'Excited to share some insights from our latest game development project! 🎮

Key elements that made our latest release successful:

1. Player-Centric Design
• Extensive playtesting
• Community feedback integration
• Iterative mechanics refinement

2. Technical Innovation
• Custom physics engine
• Dynamic difficulty adjustment
• Procedural level generation

What elements make a game truly immersive for you? 🕹️',

                'Luna (my four-legged game tester 🐕) helped me realize something important about game design today:

The best mechanics are intuitive. When designing our latest puzzle system, I observed how:

• Simple rules create complex gameplay
• Visual feedback is crucial
• Fun trumps complexity

Currently implementing these insights in our new level design. Here''s what we''re focusing on:

1. Clear visual language
2. Immediate feedback
3. Progressive complexity

What''s your favorite puzzle mechanic in games? 🧩',

                'Let''s talk about AI in game development! 🤖

We''ve been experimenting with AI for:

• NPC behavior
• Procedural content generation
• Dynamic storytelling

Early results show:
- 40% more unique NPC interactions
- Infinitely varied environments
- Personalized player experiences

The future of gaming is adaptive and intelligent. What role do you think AI should play in games? 🎲'
            ];
        WHEN 'oliviakim' THEN
            contents := ARRAY[
                'Minimalism isn''t just an aesthetic – it''s a problem-solving approach. 🎯

Recent project highlights:

1. Interface Simplification
• Reduced clicks by 60%
• Increased user satisfaction
• Cleaner visual hierarchy

2. Design Philosophy
- Remove before adding
- Question every element
- Purposeful white space

My plants taught me that growth needs space. The same applies to design. 🌿

What''s your approach to simplifying complex interfaces? ✨',

                'Color psychology in action: A case study from our latest project 🎨

We implemented a new color system that resulted in:
• 25% increase in user engagement
• 40% faster task completion
• Improved accessibility scores

Key learnings:
1. Context matters more than trends
2. Cultural significance varies
3. Accessibility first, aesthetics second

Which color combinations speak to you in digital spaces? 🌈',

                'Taking a break from my screen to tend to my plant family taught me something about UX design 🪴

Just like plants need different care, users need:
• Appropriate feedback
• Room to grow
• Regular maintenance
• The right environment

Design principles from nature:
- Adapt to conditions
- Growth takes time
- Balance is essential

How do you find inspiration in unexpected places? 🌱'
            ];
        WHEN 'marcusand' THEN
            contents := ARRAY[
                'One year into building @TechVentures, here are the hard-earned lessons: 💡

Key Insights:
1. Market Fit
• Listen more than you speak
• Iterate rapidly
• Data drives decisions

2. Team Building
• Culture eats strategy
• Hire for potential
• Remote-first mindset

3. Growth Strategy
- Sustainable > Fast
- Focus on core metrics
- Build for scale

What''s your biggest startup lesson? 🚀',

                'Today''s basketball game reminded me why sports and startup leadership are so similar 🏀

Court lessons that apply to business:
• Read the game (market)
• Trust your team
• Adapt quickly
• Stay focused under pressure

Post-game meditation insights:
1. Clarity drives decision-making
2. Balance fuels performance
3. Team chemistry is everything

How do you maintain focus under pressure? 💭',

                'Innovation isn''t about technology – it''s about solving real problems. 💡

Our latest project focuses on:

1. Sustainable Solutions
- Environmental impact
- Social responsibility
- Economic viability

2. Team Culture
• Remote collaboration
• Continuous learning
• Work-life harmony

What does meaningful innovation mean to you? 🌱'
            ];
        WHEN 'aishahsn' THEN
            contents := ARRAY[
                'Just completed a 6-month study on urban environmental solutions, and the results are both concerning and hopeful. 🌱

Key Findings:
1. Urban Green Spaces
• 30% reduction in local temperatures
• Improved air quality
• Enhanced mental health

2. Community Impact
- Increased environmental awareness
- Stronger neighborhood bonds
- Local food security

Milo (my cat 😺) reminds me daily that even small spaces can support life. What green initiatives have you noticed in your city? 🌿',

                'Breaking down our latest research on sustainable urban living 🏙️

Study highlights:
• 40% reduction in energy use
• Community garden success
• Waste reduction strategies

Practical steps for everyone:
1. Balcony gardens
2. Composting systems
3. Energy monitoring

The data shows: small changes = big impact

What sustainable practices work best for you? ♻️',

                'Social justice and environmental work are inseparable. Here''s why: 🌍

Research shows:
• Environmental issues disproportionately affect marginalized communities
• Community-led solutions have higher success rates
• Education drives change

Action items:
1. Support local initiatives
2. Share knowledge
3. Build inclusive solutions

How do you connect social and environmental issues in your community? 💚'
            ];

        WHEN 'gabsantos' THEN
            contents := ARRAY[
                'Just launched my latest AI-generated art exhibition! 🎨

The intersection of code and creativity continues to amaze me. Here''s what I learned:

1. Technical Process:
• Custom neural networks
• Style transfer algorithms
• Real-time generation

2. Creative Insights:
- AI as a collaborator
- Unexpected patterns
- Human curation matters

Check out the full gallery at link in bio! What''s your take on AI in art? 🤖✨',

                'Coffee-fueled coding session resulted in this interactive art piece today ☕️

Technical details:
• p5.js for visualization
• Web Audio API for sound
• Machine learning for pattern recognition

The piece responds to:
- Ambient sound
- User movement
- Time of day

Live demo: [link]

How do you blend technology and creativity? 💻🎨',

                'Breaking down my latest generative art project 🎯

Tools used:
• TensorFlow.js
• Three.js
• Custom shaders

The algorithm creates unique patterns based on:
1. Musical input
2. Weather data
3. Social media sentiment

Each piece is unique and unrepeatable.

What role should randomness play in digital art? 🎲'
            ];
        WHEN 'isabellan' THEN
            contents := ARRAY[
                'Excited to reveal our new eco-conscious collection! 🌿

Every piece tells a story of sustainability:

• Recycled materials
• Zero-waste patterns
• Local production
• Fair labor practices

Key numbers:
- 80% less water usage
- 60% recycled materials
- 100% transparent supply chain

Fashion can be both beautiful and responsible. What''s your favorite sustainable fashion brand? 👗♻️',

                'Vintage hunting secrets from today''s amazing finds! 🎭

Tips for successful vintage shopping:
1. Know your measurements
2. Check construction quality
3. Research eras and styles
4. Build relationships with sellers

Today''s discoveries:
• 1950s silk blouse
• 1970s wool coat
• Vintage Hermès scarf

Remember: The most sustainable garment is one that already exists! 

What''s your best vintage find? 👜✨',

                'Let''s talk about building a conscious wardrobe 🌱

Sustainable styling tips:
• Quality over quantity
• Timeless over trendy
• Versatile pieces
• Care and maintenance

Impact of fast fashion:
- Environmental damage
- Labor issues
- Resource waste

Together, we can change the industry. What''s your first step towards sustainable style? 👚💚'
            ];
        WHEN 'alexwright' THEN
            contents := ARRAY[
                'Just completed our latest urban development project, where nature meets architecture 🏗️

Key design elements:
• Living walls
• Natural light optimization
• Rainwater harvesting
• Community spaces

Results:
- 40% energy reduction
- Increased biodiversity
- Enhanced community engagement

How do you envision the future of urban spaces? 🌿🏢',

                'Today''s site visit captured through my lens 📸

Architectural photography tips:
1. Golden hour timing
2. Leading lines
3. Human scale
4. Natural framing

Project highlights:
• Sustainable materials
• Passive solar design
• Bicycle infrastructure
• Public art integration

What catches your eye in urban design? 🚴‍♂️✨',

                'Breaking down our latest sustainable building design 🏛️

Innovation features:
• Solar orientation
• Natural ventilation
• Local materials
• Green roof systems

Energy metrics:
- 70% reduction in energy use
- Zero carbon footprint
- 100% rainwater recycling

The future is sustainable by design. What green building features interest you most? 🌱🏆'
            ];

    END CASE;

    RETURN contents[1 + floor(random() * array_length(contents, 1))];
END;
$$ LANGUAGE plpgsql;

-- DO block for creating posts
DO $$
DECLARE
    user_record RECORD;
    post_count INTEGER;
    start_date TIMESTAMP;
    post_interval INTERVAL;
BEGIN
    -- Set start date to 2 years ago
    start_date := NOW() - INTERVAL '2 years';
    
    FOR user_record IN SELECT id, username FROM users WHERE username != 'demo' LOOP
        post_count := floor(random() * 15 + 10)::INTEGER; -- Random number between 10 and 25
        
        FOR i IN 1..post_count LOOP
            -- Calculate a random interval between start_date and now
            post_interval := (random() * (NOW() - start_date));
            
            INSERT INTO posts (
                id,
                title,
                description,
                created_at,
                user_id
            ) VALUES (
                gen_random_uuid(),
                get_random_title_for_user(user_record.username),
                get_random_content_for_user(user_record.username),
                start_date + post_interval,
                user_record.id
            );
        END LOOP;
    END LOOP;
END $$;
